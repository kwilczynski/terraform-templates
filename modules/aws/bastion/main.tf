data "aws_route53_zone" "mod" {
  count = "${var.zone_id != "" ? var.domain_name != "" ? 0 : 1 : 0}"

  zone_id = "${var.zone_id}"
}

data "template_file" "mod" {
  template = "${file(format("%s/templates/%s", path.module, "cloud-config.tpl"))}"

  vars {
    allocation_id = "${coalesce(var.eip_allocation_id, join("",
                       aws_eip.mod.*.id))}"
  }
}

data "template_cloudinit_config" "mod" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.cfg"
    content_type = "text/cloud-config"
    content      = "${coalesce(var.cloud_config, join("",
                      data.template_file.mod.*.rendered))}"
  }

  part {
    filename     = "additional_user_data.sh"
    content_type = "text/x-shellscript"
    content      = "${var.additional_user_data}"
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  count = "${var.iam_instance_profile != "" ? 0 : 1}"

  statement {
    principals {
      type        = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "associate_address_policy" {
  count = "${var.iam_instance_profile != "" ? 0 : 1}"

  statement {
    actions = [
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress"
    ]

    resources = [
      "*"
    ]
  }
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_iam_role" "mod" {
  count = "${var.iam_instance_profile != "" ? 0 : 1}"

  name               = "${format("%s-bastion-instance-role", var.stack_name)}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy" "mod" {
  count = "${var.iam_instance_profile != "" ? 0 : 1}"

  name   = "${format("%s-bastion-role-policy", var.stack_name)}"
  role   = "${aws_iam_role.mod.id}"
  policy = "${data.aws_iam_policy_document.associate_address_policy.json}"
}

resource "aws_iam_instance_profile" "mod" {
  count = "${var.iam_instance_profile != "" ? 0 : 1}"

  name = "${format("%s-bastion-instance-profile", var.stack_name)}"
  role = "${aws_iam_role.mod.name}"

  // This is to resolve an issue with Instance Profile creation,
  // where the underlying profile is still being created, but other
  // resources that use it would try to access it already, see:
  // https://github.com/hashicorp/terraform/issues/1885
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = ["aws_iam_role.mod"]
}

resource "aws_security_group" "mod" {
  count = "${length(var.security_groups) != 0 ? 0 : 1}"

  name        = "${format("%s-bastion-security-group", var.stack_name)}"
  description = "${format("Security Group for Bastion - %s", var.stack_name)}"

  vpc_id = "${var.vpc_id}"

  tags = {
    Name        = "${format("%s-bastion-security-group", var.stack_name)}"
    StackName   = "${var.stack_name}"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}

resource "aws_security_group_rule" "rule_ingress_allow_icmp" {
  count = "${length(var.security_groups) != 0 ? 0 : var.allow_icmp ? 1 : 0}"

  type = "ingress"

  protocol  = "icmp"
  from_port = -1
  to_port   = -1

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_ingress_allow_icmp_destination_unreachable" {
  count = "${length(var.security_groups) != 0 ? 0 : var.allow_icmp ? 0 : 1}"

  type = "ingress"

  protocol  = "icmp"
  from_port = 3
  to_port   = 3

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_ingress_allow_tcp_port_22_from_cidrs" {
  count = "${length(var.security_groups) != 0 ? 0 : 1}"

  type = "ingress"

  protocol  = "tcp"
  from_port = 22
  to_port   = 22

  cidr_blocks = ["${var.allowed_cidr_blocks}"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_ingress_allow_tcp_port_22_from_security_groups" {
  count = "${length(var.security_groups) != 0
             ? 0 : length(var.allowed_security_groups) == 0
             ? 0 : length(var.allowed_security_groups)}"

  type = "ingress"

  protocol  = "tcp"
  from_port = 22
  to_port   = 22

  source_security_group_id = "${element(var.allowed_security_groups, count.index)}"

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_egress_allow_everything" {
  count = "${length(var.security_groups) != 0 ? 0 : 1}"

  type = "egress"

  protocol  = -1
  from_port = 0
  to_port   = 0

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_eip" "mod" {
  count = "${var.eip_allocation_id != "" ? 0 : 1}"

  vpc = true
}

resource "aws_launch_configuration" "mod" {
  name_prefix = "${format("%s-bastion-launch-configuration-", var.stack_name)}"

  image_id      = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  iam_instance_profile = "${coalesce(var.iam_instance_profile, join("",
                            aws_iam_instance_profile.mod.*.name))}"

  security_groups = ["${coalescelist(var.security_groups, aws_security_group.mod.*.id)}"]

  associate_public_ip_address = false

  user_data = "${coalesce(var.user_data, join("",
                 data.template_cloudinit_config.mod.*.rendered))}"

  root_block_device {
    volume_type = "${var.volume_type}"
    volume_size = "${var.volume_size}"
  }

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      "image_id",
      "user_data"
    ]
  }

  depends_on = [
    "aws_eip.mod",
    "null_resource.depends_on"
  ]
}

resource "aws_autoscaling_group" "mod" {
  name = "${format("%s-bastion-autoscaling-group", var.stack_name)}"

  vpc_zone_identifier = ["${var.subnet_ids}"]

  force_delete = false

  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  wait_for_capacity_timeout = 0

  health_check_type         = "EC2"
  health_check_grace_period = 60

  launch_configuration = "${aws_launch_configuration.mod.name}"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  tags = [
    "${concat(
      list(
        map(
          "key",   "Name",
          "value", "${format("%s-bastion-instance", var.stack_name)}",
          "propagate_at_launch", true
        ),
        map(
          "key",   "StackName",
          "value", "${var.stack_name}",
          "propagate_at_launch", true
        ),
        map(
          "key",   "Environment",
          "value", "${var.environment}",
          "propagate_at_launch", true
        ),
        map(
          "key",   "Version",
          "value", "${var.version}",
          "propagate_at_launch", true
        ),
        map(
          "key",   "Role",
          "value", "${var.role}",
          "propagate_at_launch", true
        )
      ),
    var.tags)}"
  ]

  depends_on = ["aws_launch_configuration.mod"]
}

resource "aws_route53_record" "public_a" {
  count = "${var.zone_id == "" ? 0 : 1}"

  zone_id = "${coalesce(var.zone_id, "-")}"

  name = "${format("bastion-001.%s", coalesce(var.domain_name,
            join("", data.aws_route53_zone.mod.*.name)))}"

  type = "A"
  ttl  = 60

  records = ["${aws_eip.mod.public_ip}"]

  depends_on = ["aws_eip.mod"]
}

resource "aws_route53_record" "public_cname" {
  count = "${var.zone_id == "" ? 0 : 1}"

  zone_id = "${coalesce(var.zone_id, "-")}"

  name = "${format("bastion.%s", coalesce(var.domain_name,
            join("", data.aws_route53_zone.mod.*.name)))}"

  type = "CNAME"
  ttl  = 60

  records = ["${aws_route53_record.public_a.fqdn}"]

  depends_on = ["aws_route53_record.public_a"]
}
