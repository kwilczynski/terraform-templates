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

  cidr_blocks         = ["${var.cidr_blocks}"]
  availability_zones  = ["${var.availability_zones}"]

  map_public_ip_on_launch = true

  tags = "${merge(map(
    "Public", "true"
  ), var.tags)}"

  depends_on = ["${var.depends_on}"]
}

module "route_table" {
  source = "../../route-table"

  stack_name  = "${var.stack_name}"
  environment = "${var.environment}"
  version     = "${var.version}"

  name = "${format("%s-public", coalesce(var.region, join("",
            data.aws_region.mod.*.name)))}"

  vpc_id = "${var.vpc_id}"

  tags = "${merge(map(
    "Public", "true"
  ), var.tags)}"

  depends_on = ["${module.subnet.ids}"]
}

module "route" {
  source = "../../route"

  destination_cidr_block = "0.0.0.0/0"

  route_table_id = "${module.route_table.id}"
  gateway_id     = "${var.gateway_id}"

  depends_on = ["${module.route_table.id}"]
}

resource "aws_route_table_association" "mod" {
  count = "${length(var.cidr_blocks)}"

  route_table_id = "${module.route_table.id}"
  subnet_id      = "${element(module.subnet.ids, count.index)}"

  depends_on = ["module.route"]
}
