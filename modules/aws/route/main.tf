resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_route" "mod" {
  route_table_id = "${var.route_table_id}"

  destination_cidr_block    = "${var.destination_cidr_block}"
  vpc_peering_connection_id = "${var.vpc_peering_connection_id}"
  gateway_id                = "${var.gateway_id}"
  nat_gateway_id            = "${var.nat_gateway_id}"
  instance_id               = "${var.instance_id}"
  network_interface_id      = "${var.network_interface_id}"

  depends_on = ["null_resource.depends_on"]
}

resource "aws_route_table_association" "mod" {
  count = "${var.subnet_id == "" ? 0 : 1}"

  subnet_id      = "${var.subnet_id}"
  route_table_id = "${var.route_table_id}"

  depends_on = ["aws_route.mod"]
}
