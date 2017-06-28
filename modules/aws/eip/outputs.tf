output "id" {
  value = "${aws_eip.mod.id}"
}

output "public_ip" {
  value = "${aws_eip.mod.public_ip}"
}
