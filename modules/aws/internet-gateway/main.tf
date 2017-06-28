resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${var.vpc_id}"

  tags = "${merge(map(
    "Name",        "${format("%s-internet-gateway", var.stack_name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}
