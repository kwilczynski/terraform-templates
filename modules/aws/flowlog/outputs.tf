output "id" {
  value = "${aws_flow_log.mod.id}"
}

output "role_unique_id" {
  value = "${aws_iam_role.mod.unique_id}"
}

output "role_arn" {
  value = "${aws_iam_role.mod.arn}"
}

output "role_name" {
  value = "${aws_iam_role.mod.name}"
}

output "policy_id" {
  value = "${aws_iam_role_policy.mod.id}"
}

output "policy_name" {
  value = "${aws_iam_role_policy.mod.id}"
}
