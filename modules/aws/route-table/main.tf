resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_route_table" "mod" {
  vpc_id = "${var.vpc_id}"

  propagating_vgws = ["${var.propagating_vgws}"]

  tags = "${merge(map(
    "Name",        "${format("%s-%s-route-table", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}
