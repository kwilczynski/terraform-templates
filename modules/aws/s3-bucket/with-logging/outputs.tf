output "id" {
  value = "${module.s3_bucket.id}"
}

output "arn" {
  value = "${module.s3_bucket.arn}"
}

output "hosted_zone_id" {
  value = "${module.s3_bucket.hosted_zone_id}"
}

output "bucket_domain_name" {
  value = "${module.s3_bucket.bucket_domain_name}"
}

output "bucket_url" {
  value = "${module.s3_bucket.bucket_url}"
}

output "principal_arns" {
  value = ["${module.s3_bucket.principal_arns}"]
}
