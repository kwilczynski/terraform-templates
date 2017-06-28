resource "aws_s3_bucket" "mod" {
  bucket = "${format("%s-log", var.bucket)}"

  acl = "log-delivery-write"

  force_destroy = "${var.force_destroy}"

  lifecycle_rule {
    enabled = true

    id     = "${format("%s-log-lifecycle", var.bucket)}"
    prefix = ""

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  tags = "${merge(map(
    "Name",        "${format("%s-%s-log-s3-bucket", var.stack_name, var.bucket)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  provisioner "local-exec" {
    command = "sleep 30"
  }
}

module "s3_bucket" {
  source = "../"

  stack_name  = "${var.stack_name}"
  environment = "${var.environment}"
  version     = "${var.version}"

  region = "${var.region}"
  
  server_side_encryption = "${var.server_side_encryption}"
  principal_arns         = ["${var.principal_arns}"]

  bucket = "${var.bucket}"
  acl    = "${var.acl}"
  policy = "${var.policy}"

  force_destroy = "${var.force_destroy}"

  versioning = true

  logging = "${list(map(
    "target_bucket", "${format("%s-log", var.bucket)}"
  ))}"

  tags = "${var.tags}"

  depends_on = [
    "aws_s3_bucket.mod",
    "${var.depends_on}"
  ]
}