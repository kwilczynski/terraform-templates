resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

data "aws_subnet_ids" "public" {
  count = "${var.public ? 1 : 0}"

  vpc_id = "${var.vpc_id}"

  tags {
    Public = "true"
  }

  depends_on = ["null_resource.depends_on"]
}

data "aws_subnet_ids" "private" {
  count = "${var.private ? 1 : 0}"

  vpc_id = "${var.vpc_id}"

  tags {
    Private = "true"
  }

  depends_on = ["null_resource.depends_on"]
}
