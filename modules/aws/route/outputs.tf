output "route_table_id" {
  value = "${aws_route.mod.route_table_id}"
}

output "destination_cidr_block" {
  value = "${aws_route.mod.destination_cidr_block}"
}

output "vpc_peering_connection_id" {
  value = "${aws_route.mod.vpc_peering_connection_id}"
}

output "gateway_id" {
  value = "${aws_route.mod.gateway_id}"
}

output "nat_gateway_id" {
  value = "${aws_route.mod.nat_gateway_id}"
}

output "instance_id" {
  value = "${aws_route.mod.instance_id}"
}

output "network_interface_id" {
  value = "${aws_route.mod.network_interface_id}"
}

output "route_table_association_id" {
  value = "${aws_route_table_association.mod.id}"
}

output "subnet_id" {
  value = "${aws_route_table_association.mod.subnet_id}"
}
