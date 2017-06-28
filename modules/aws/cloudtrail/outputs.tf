output "id" {
  value = "${aws_cloudtrail.mod.id}"
}

output "home_region" {
  value = "${aws_cloudtrail.mod.home_region}"
}
output "arn" {
  value = "${aws_cloudtrail.mod.arn}"
}

output "bucket_id" {
  value = "${aws_s3_bucket.mod.id}"
}

output "bucket_arn" {
  value = "${aws_s3_bucket.mod.arn}"
}

output "bucket_name" {
  value = "${coalesce(var.s3_bucket_name, join("",
             data.null_data_source.mod.*.outputs.bucket))}"
}
