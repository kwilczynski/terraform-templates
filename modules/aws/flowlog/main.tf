data "aws_iam_policy_document" "role" {
  statement {
    principals {
      type        = "Service"
      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = [
      "*"
    ]
  }
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_iam_role" "mod" {
  name               = "${format("%s-%s-flowlog-role", var.stack_name, var.name)}"
  assume_role_policy = "${coalesce(var.assume_role_policy, join("",
                          data.aws_iam_policy_document.role.*.json))}"
}

resource "aws_iam_role_policy" "mod" {
  name = "${format("%s-%s-flowlog-role-policy", var.stack_name, var.name)}"
  role = "${aws_iam_role.mod.id}"

  policy = "${coalesce(var.policy, join("",
              data.aws_iam_policy_document.role_policy.*.json))}"

  depends_on = ["aws_iam_role.mod"]
}

resource "aws_cloudwatch_log_group" "mod" {
  name = "${format("%s-%s-flowlog", var.stack_name, var.name)}"

  retention_in_days = "${var.retention_in_days}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-flowlog-cloudwatch-log-group", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"
}

resource "aws_flow_log" "mod" {
  count = "${var.enable_logging ? 1 : 0}"

  log_group_name = "${aws_cloudwatch_log_group.mod.name}"
  iam_role_arn   = "${aws_iam_role.mod.arn}"

  traffic_type = "${var.traffic_type}"

  vpc_id    = "${var.vpc_id}"
  subnet_id = "${var.subnet_id}"
  eni_id    = "${var.eni_id}"

  depends_on = [
    "aws_cloudwatch_log_group.mod",
    "null_resource.depends_on"
  ]
}
