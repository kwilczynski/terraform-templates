output "vpc_id" {
  value = "${module.subnet.vpc_id}"
}

output "route_table_id" {
  value = "${module.route_table.id}"
}

output "ids" {
  value = ["${module.subnet.ids}"]
}

output "cidr_blocks" {
  value = ["${module.subnet.cidr_blocks}"]
}

output "availability_zones" {
  value = ["${module.subnet.availability_zones}"]
}
