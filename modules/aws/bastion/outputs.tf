output "private_ip" {
  value = "${aws_eip.mod.private_ip}"
}

output "public_ip" {
  value = "${aws_eip.mod.public_ip}"
}

output "public_a" {
  value = "${aws_route53_record.public_a.fqdn}"
}

output "public_cname" {
  value = "${aws_route53_record.public_cname.fqdn}"
}

output "eip_allocation_id" {
  value = "${aws_eip.mod.id}"
}

output "role_id" {
  value = "${aws_iam_role.mod.id}"
}

output "role_arn" {
  value = "${aws_iam_role.mod.arn}"
}

output "security_group_id" {
  value = "${element(coalescelist(var.security_groups, aws_security_group.mod.*.id), 0)}"
}

output "security_groups" {
  value = ["${coalescelist(var.security_groups, aws_security_group.mod.*.id)}"]
}
