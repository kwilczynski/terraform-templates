resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_security_group" "mod" {
  name        = "${format("%s-%s-security-group", var.stack_name, var.name)}"
  description = "${coalesce(var.description, format("Security Group - %s", var.name))}"

  vpc_id = "${var.vpc_id}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-security-group", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}

resource "aws_security_group_rule" "rule_ingress_allow_icmp" {
  count = "${var.allow_icmp ? 1 : 0}"

  type = "ingress"

  protocol  = "icmp"
  from_port = -1
  to_port   = -1

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_egress_allow_icmp" {
  count = "${var.allow_icmp ? 1 : 0}"

  type = "egress"

  protocol  = "icmp"
  from_port = -1
  to_port   = -1

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_ingress_allow_icmp_destination_unreachable" {
  count = "${var.allow_icmp ? 0 : 1}"

  type = "ingress"

  protocol  = "icmp"
  from_port = 3
  to_port   = 3

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}

resource "aws_security_group_rule" "rule_egress_allow_icmp_destination_unreachable" {
  count = "${var.allow_icmp ? 0 : 1}"

  type = "egress"

  protocol  = "icmp"
  from_port = 3
  to_port   = 3

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mod.id}"

  depends_on = ["aws_security_group.mod"]
}