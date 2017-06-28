output "key_id" {
  value = "${aws_kms_key.mod.key_id}"
}

output "arn" {
  value = "${aws_kms_key.mod.arn}"
}

output "alias_name" {
  value = "${data.null_data_source.mod.outputs.alias_name}"
}

output "alias_arn" {
  value = "${aws_kms_alias.mod.arn}"
}
