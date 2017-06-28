data "null_data_source" "mod" {
  inputs {
    alias_name = "${format("alias/%s", element(split("alias/", coalesce(var.alias,
                    format("%s-%s-kms-alias", var.stack_name, var.name))), 1))}"
  }
}

data "aws_caller_identity" "mod" {
  count = "${length(var.principal_arns) != 0 ? 0 : 1}"
}

data "aws_iam_policy_document" "mod" {
  count = "${var.policy != "" ? 0 : 1}"

  statement {
    actions = [
      "kms:*"
    ]

    resources = [
      "*"
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

resource "aws_kms_key" "mod" {
  description = "${coalesce(var.description, format("KMS Key - %s", var.name))}"

  key_usage = "${var.key_usage}"
  policy    = "${coalesce(var.policy, join("",
                 data.aws_iam_policy_document.mod.*.json))}"

  deletion_window_in_days = "${var.deletion_window_in_days}"

  is_enabled          = "${var.is_enabled}"
  enable_key_rotation = "${var.enable_key_rotation}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-kms-key", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}

resource "aws_kms_alias" "mod" {
  name = "${format("alias/%s", element(split("alias/", coalesce(var.alias,
            data.null_data_source.mod.outputs.alias_name)), 1))}"

  target_key_id = "${aws_kms_key.mod.key_id}"

  depends_on = ["aws_kms_key.mod"]
}
