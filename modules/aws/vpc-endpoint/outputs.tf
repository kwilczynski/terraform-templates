output "id" {
  value = "${aws_vpc_endpoint.mod.id}"
}

output "vpc_id" {
  value = "${aws_vpc_endpoint.mod.vpc_id}"
}

output "prefix_list_id" {
  value = "${aws_vpc_endpoint.mod.route_table_id}"
}

output "cidr_blocks" {
  value = ["${aws_vpc_endpoint.mod.cidr_blocks}"]
}

output "route_table_ids" {
  value = ["${aws_vpc_endpoint.mod.route_table_ids}"]
}
