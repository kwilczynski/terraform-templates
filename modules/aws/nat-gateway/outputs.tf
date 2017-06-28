output "ids" {
  value = ["${aws_nat_gateway.mod.*.id}"]
}

output "allocation_ids" {
  value = ["${aws_nat_gateway.mod.*.allocation_id}"]
}

output "subnet_ids" {
  value = ["${aws_nat_gateway.mod.*.subnet_id}"]
}

output "network_interface_ids" {
  value = ["${aws_nat_gateway.mod.*.network_interface_id}"]
}

output "public_ips" {
  value = ["${aws_nat_gateway.mod.*.public_ip}"]
}

output "private_ips" {
  value = ["${aws_nat_gateway.mod.*.private_ip}"]
}
