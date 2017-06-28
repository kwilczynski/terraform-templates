output "zone_id" {
  value = "${module.route53_zone.zone_id}"
}

output "name_servers" {
  value = ["${module.route53_zone.name_servers}"]
}
