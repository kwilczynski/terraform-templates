resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_route53_zone" "mod" {
  name    = "${var.name}"
  comment = "${coalesce(var.comment, format("Hosted Zone - %s", var.stack_name))}"

  vpc_id = "${var.vpc_id}"

  force_destroy = "${var.force_destroy}"

  tags = "${merge(map(
    "Name",        "${format("%s-route53-zone", var.stack_name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}",
    "${var.vpc_id == "" ? "Public" : "Private"}", "true"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}
