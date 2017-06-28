data "aws_region" "mod" {
  count = "${var.region != "" ? 0 : 1}"

  current = true
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_subnet" "mod" {
  count = "${length(var.cidr_blocks)}"

  vpc_id = "${var.vpc_id}"

  cidr_block        = "${element(var.cidr_blocks, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-%s-%s-subnet", var.stack_name,
                      coalesce(var.region, join("", data.aws_region.mod.*.name)),
                      var.map_public_ip_on_launch ? "public" : "private",
                      substr(element(var.availability_zones, count.index), -1, 1))}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}
