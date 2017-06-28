resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_network_interface" "mod" {
  subnet_id = "${var.subnet_id}"

  description = "${coalesce(var.description, format("Elastic Network Interface - %s", var.name))}"

  private_ips       = ["${var.private_ips}"]
  private_ips_count = "${var.private_ips_count}"

  security_groups = ["${var.security_groups}"]

  source_dest_check = "${var.source_dest_check}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-network-interface", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}

resource "aws_network_interface_attachment" "mod" {
  count = "${var.instance_id == "" ? 0 : 1}"

  instance_id  = "${var.instance_id}"
  device_index = "${var.device_index}"

  network_interface_id = "${aws_network_interface.mod.id}"

  depends_on = ["aws_network_interface.mod"]
}
