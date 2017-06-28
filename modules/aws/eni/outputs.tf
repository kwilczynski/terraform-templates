output "subnet_id" {
  value = "${aws_network_interface.mod.subnet_id}"
}

output "private_ip" {
  value = "${element(aws_network_interface.mod.private_ips, 0)}"
}

output "private_ips" {
  value = ["${aws_network_interface.mod.private_ips}"]
}

output "security_groups" {
  value = ["${aws_network_interface.mod.security_groups}"]
}

output "instance_id" {
  value = "${aws_network_interface_attachment.mod.instance_id}"
}

output "network_interface_id" {
  value = "${aws_network_interface_attachment.mod.network_interface_id}"
}

output "device_index" {
  value = "${aws_network_interface_attachment.mod.device_index}"
}
