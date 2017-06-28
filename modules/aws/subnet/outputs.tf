output "vpc_id" {
  value = "${aws_subnet.mod.vpc_id}"
}

output "ids" {
  value = ["${aws_subnet.mod.*.id}"]
}

output "cidr_blocks" {
  value = ["${aws_subnet.mod.*.cidr_block}"]
}

output "availability_zones" {
  value = ["${aws_subnet.mod.*.availability_zone}"]
}
