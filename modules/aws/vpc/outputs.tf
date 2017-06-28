output "id" {
  value = "${aws_vpc.mod.id}"
}

output "cidr_block" {
  value = "${aws_vpc.mod.cidr_block}"
}

output "zone_id" {
  value = "${aws_route53_zone_association.mod.zone_id}"
}
