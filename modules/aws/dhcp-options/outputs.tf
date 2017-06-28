output "id" {
  value = "${aws_vpc_dhcp_options.mod.id}"
}

output "domain_name" {
  value = "${data.null_data_source.mod.outputs.domain_name}"
}
