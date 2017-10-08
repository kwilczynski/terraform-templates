data "aws_vpc_endpoint_service" "mod" {
  service = "${lower(var.service)}"
}

data "aws_iam_policy_document" "mod" {
  count = "${var.policy != "" ? 0 : 1}"

  statement {
    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }

    actions = [
      "*"
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

resource "aws_vpc_endpoint" "mod" {
  vpc_id       = "${var.vpc_id}"
  service_name = "${data.aws_vpc_endpoint_service.mod.service_name}"

  route_table_ids = ["${var.route_table_ids}"]

  policy = "${coalesce(var.policy, join("",
              data.aws_iam_policy_document.mod.*.json))}"

  depends_on = ["null_resource.depends_on"]
}
