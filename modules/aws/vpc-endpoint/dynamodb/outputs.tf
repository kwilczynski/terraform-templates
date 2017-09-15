output "id" {
  value = "${module.vpc_endpoint.id}"
}

output "vpc_id" {
  value = "${module.vpc_endpoint.vpc_id}"
}

output "prefix_list_id" {
  value = "${module.vpc_endpoint.prefix_list_id}"
}

output "cidr_blocks" {
  value = ["${module.vpc_endpoint.cidr_blocks}"]
}

output "route_table_ids" {
  value = ["${module.vpc_endpoint.route_table_ids}"]
}
