output "zone_id" {
  value = "${aws_route53_zone.mod.zone_id}"
}

output "name_servers" {
  value = ["${aws_route53_zone.mod.name_servers}"]
}
