data "aws_region" "mod" {
  count = "${var.region != "" ? 0 : 1}"

  current = true
}

data "null_data_source" "mod" {
  inputs = {
    domain_name = "${coalesce(var.domain_name, coalesce(var.region,
                    join("", data.aws_region.mod.*.name)) == "us-east-1"
                    ? "ec2.internal" : format("%s.compute.internal",
                    coalesce(var.region, join("",
                    data.aws_region.mod.*.name))))}"
  }
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_vpc_dhcp_options" "mod" {
  domain_name = "${data.null_data_source.mod.outputs.domain_name}"

  domain_name_servers = ["${var.domain_name_servers}"]
  ntp_servers         = ["${var.ntp_servers}"]

  tags = "${merge(map(
    "Name",        "${format("%s-dhcp-options", var.stack_name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}

resource "aws_vpc_dhcp_options_association" "mod" {
  vpc_id          = "${var.vpc_id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.mod.id}"

  depends_on = ["aws_vpc_dhcp_options.mod"]
}
