data "aws_region" "mod" {
  count = "${var.region != "" ? 0 : 1}"

  current = true
}

module "subnet" {
  source = "../"

  stack_name  = "${var.stack_name}"
  environment = "${var.environment}"
  version     = "${var.version}"

  region = "${coalesce(var.region, join("", data.aws_region.mod.*.name))}"
  vpc_id = "${var.vpc_id}"

  cidr_blocks        = ["${var.cidr_blocks}"]
  availability_zones = ["${var.availability_zones}"]

  tags = "${merge(map(
    "Private", "true"
  ), var.tags)}"

  depends_on = ["${var.depends_on}"]
}

resource "aws_route_table" "mod" {
  count = "${length(var.cidr_blocks)}"

  vpc_id = "${var.vpc_id}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-private-%s-route-table", var.stack_name,
                      coalesce(var.region, join("", data.aws_region.mod.*.name)),
                      substr(element(var.availability_zones, count.index), -1, 1))}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}",
    "Private",     "true"
  ), var.tags)}"

  depends_on = ["module.subnet"]
}

resource "aws_route" "mod" {
  count = "${length(var.cidr_blocks)}"

  destination_cidr_block = "0.0.0.0/0"

  route_table_id = "${element(aws_route_table.mod.*.id, count.index)}"
  nat_gateway_id = "${element(var.nat_gateway_ids, count.index)}"

  depends_on = ["aws_route_table.mod"]
}

resource "aws_route_table_association" "mod" {
  count = "${length(var.cidr_blocks)}"

  route_table_id = "${element(aws_route_table.mod.*.id, count.index)}"
  subnet_id      = "${element(module.subnet.ids, count.index)}"

  depends_on = ["aws_route.mod"]
}
