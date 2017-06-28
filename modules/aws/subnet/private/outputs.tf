output "vpc_id" {
  value = "${module.subnet.vpc_id}"
}

output "ids" {
  value = ["${module.subnet.ids}"]
}

output "route_table_ids" {
  value = ["${aws_route_table.mod.*.id}"]
}

output "cidr_blocks" {
  value = ["${module.subnet.cidr_blocks}"]
}

output "availability_zones" {
  value = ["${module.subnet.availability_zones}"]
}
