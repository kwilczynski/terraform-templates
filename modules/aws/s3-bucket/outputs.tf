output "id" {
  value = "${aws_s3_bucket.mod.id}"
}

output "arn" {
  value = "${aws_s3_bucket.mod.arn}"
}

output "hosted_zone_id" {
  value = "${aws_s3_bucket.mod.hosted_zone_id}"
}

output "bucket_domain_name" {
  value = "${aws_s3_bucket.mod.bucket_domain_name}"
}

output "bucket_url" {
  value = "${format("https://s3.%s.amazonaws.com/%s",
             coalesce(var.region, join("",
             data.aws_region.mod.*.name)),
             var.bucket)}"
}

output "principal_arns" {
  value = ["${var.principal_arns}"]
}
