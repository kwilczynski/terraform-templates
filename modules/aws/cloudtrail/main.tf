data "null_data_source" "mod" {
  count = "${var.s3_bucket_name != "" ? 0 : 1}"

  inputs = {
    bucket = "${format("%s-%s-s3-bucket-cloudtrial", var.stack_name, var.name)}"
  }
}

data "aws_iam_policy_document" "mod" {
  count = "${var.s3_bucket_name != "" ? 0 : 1}"

  statement {
    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      "${format("arn:aws:s3:::%s", data.null_data_source.mod.outputs.bucket)}"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
  }

  statement {
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${format("arn:aws:s3:::%s/*", data.null_data_source.mod.outputs.bucket)}"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }
  }
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_s3_bucket" "mod" {
  count = "${var.s3_bucket_name != "" ? 0 : 1}"

  bucket = "${data.null_data_source.mod.outputs.bucket}"

  acl    = "private"
  policy = "${data.aws_iam_policy_document.mod.json}"

  force_destroy = "${var.force_destroy}"

  lifecycle_rule {
    enabled = true

    id     = "${format("%s-lifecycle", data.null_data_source.mod.outputs.bucket)}"
    prefix = ""

    expiration {
      days = "${var.expiration_days}"
    }
  }

  tags = "${merge(map(
    "Name",        "${data.null_data_source.mod.outputs.bucket}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"
}

resource "aws_cloudtrail" "mod" {
  name = "${format("%s-%s-cloudtrial", var.stack_name, var.name)}"

  kms_key_id = "${var.kms_key_id}"

  enable_logging             = "${var.enable_logging}"
  enable_log_file_validation = "${var.enable_log_file_validation}"

  include_global_service_events = "${var.include_global_service_events}"
  is_multi_region_trail         = "${var.is_multi_region_trail}"

  s3_bucket_name = "${coalesce(var.s3_bucket_name, join("",
                      data.null_data_source.mod.*.outputs.bucket))}"
  s3_key_prefix  = "${var.s3_key_prefix}"

  cloud_watch_logs_role_arn  = "${var.cloud_watch_logs_role_arn}"
  cloud_watch_logs_group_arn = "${var.cloud_watch_logs_group_arn}"

  sns_topic_name = "${var.sns_topic_name}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-cloudtrial", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = [
    "aws_s3_bucket.mod",
    "null_resource.depends_on"
  ]
}
