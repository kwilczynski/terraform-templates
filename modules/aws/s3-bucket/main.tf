data "aws_caller_identity" "mod" {
  count = "${length(var.principal_arns) != 0 ? 0 : 1}"
}

data "aws_region" "mod" {
  count = "${var.region != "" ? 0 : 1}"

  current = true
}

data "aws_iam_policy_document" "mod" {
  count = "${var.policy != "" ? 0 : 1}"

  statement {
    effect = "Deny"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = [
      "${format("arn:aws:s3:::%s/*", var.bucket)}"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false"
      ]
    }

    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }
  }

  statement {
    effect = "Deny"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${format("arn:aws:s3:::%s/*", var.bucket)}"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "public-read",
        "public-read-write"
      ]
    }

    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }
  }

  statement {
    effect = "Deny"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${format("arn:aws:s3:::%s/*", var.bucket)}"
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "${var.server_side_encryption}"
      ]
    }

    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }
  }

  statement {
    effect = "Deny"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${format("arn:aws:s3:::%s/*", var.bucket)}"
    ]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "true"
      ]
    }

    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }
  }

  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "${format("arn:aws:s3:::%s", var.bucket)}"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "${coalescelist(var.principal_arns, list(
           format("arn:aws:iam::%s:root", join("",
           data.aws_caller_identity.mod.*.account_id))))}"
      ]
    }
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      "${format("arn:aws:s3:::%s/*", var.bucket)}"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "${coalescelist(var.principal_arns, list(
           format("arn:aws:iam::%s:root", join("",
           data.aws_caller_identity.mod.*.account_id))))}"
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
  bucket = "${var.bucket}"

  acl    = "${var.acl}"
  policy = "${coalesce(var.policy, join("",
              data.aws_iam_policy_document.mod.*.json))}"

  force_destroy = "${var.force_destroy}"

  versioning {
    enabled = "${var.versioning}"
  }

  logging = ["${var.logging}"]

  tags = "${merge(map(
    "Name",        "${format("%s-%s-s3-bucket", var.stack_name, var.bucket)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

 depends_on = ["null_resource.depends_on"]
}
