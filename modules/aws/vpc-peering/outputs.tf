output "id" {
  value = "${aws_vpc_peering_connection.mod.id}"
}

output "vpc_id" {
  value = "${aws_vpc_peering_connection.mod.vpc_id}"
}

output "peer_vpc_id" {
  value = "${aws_vpc_peering_connection.mod.peer_vpc_id}"
}
