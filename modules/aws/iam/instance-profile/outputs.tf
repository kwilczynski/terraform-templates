output "id" {
  value = "${aws_iam_instance_profile.mod.id}"
}

output "arn" {
  value = "${aws_iam_instance_profile.mod.arn}"
}

output "name" {
  value = "${aws_iam_instance_profile.mod.name}"
}

output "role_id" {
  value = "${aws_iam_role.mod.id}"
}

output "role_arn" {
  value = "${aws_iam_role.mod.arn}"
}
