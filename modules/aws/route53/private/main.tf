data "aws_route53_zone" "mod" {
  count = "${var.name != "" ? 0 : 1}"

  zone_id = "${var.zone_id}"
}

module "route53_zone" {
  source = "../"

  stack_name  = "${var.stack_name}"
  environment = "${var.environment}"
  version     = "${var.version}"

  name    = "${coalesce(var.name, join("", data.aws_route53_zone.mod.*.name))}"
  comment = "${coalesce(var.comment, format("Private Hosted Zone - %s", var.stack_name))}"

  vpc_id = "${var.vpc_id}"

  force_destroy = "${var.force_destroy}"

  tags = "${merge(map(
    "Name", "${format("%s-private-route53-zone", var.stack_name)}"
  ), var.tags)}"

  depends_on = ["${var.depends_on}"]
}
