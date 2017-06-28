module "ptr" {
  source = "../../../common/ptr-calculator"

  host = "${var.cidr_block}"
  type = "network"
}

module "route53_zone" {
  source = "../"

  stack_name  = "${var.stack_name}"
  environment = "${var.environment}"
  version     = "${var.version}"

  name = "${module.ptr.ptr}"

  comment = "${coalesce(var.comment, format("Private Reverse Hosted Zone - %s (%s)",
               var.stack_name, var.cidr_block))}"

  vpc_id = "${var.vpc_id}"

  force_destroy = "${var.force_destroy}"

  tags = "${merge(map(
    "Name",   "${format("%s-private-reverse-route53-zone", var.stack_name)}",
    "Reverse", "true"
  ), var.tags)}"

  depends_on = ["${var.depends_on}"]
}
