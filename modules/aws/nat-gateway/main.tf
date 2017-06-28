data "aws_route53_zone" "mod" {
  count = "${var.zone_id != "" ? var.domain_name != "" ? 0 : 1 : 0}"

  zone_id = "${var.zone_id}"
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_eip" "mod" {
  count = "${length(var.eip_allocation_ids) == 0 ? var.count : 0}"

  vpc = true
}

resource "aws_nat_gateway" "mod" {
  count = "${var.count}"

  allocation_id = "${element(coalescelist(var.eip_allocation_ids, aws_eip.mod.*.id), count.index)}"
  subnet_id     = "${element(var.subnet_ids, count.index)}"

  depends_on = [
    "aws_eip.mod",
    "null_resource.depends_on"
  ]
}

resource "aws_route53_record" "mod" {
  count = "${var.zone_id != "" ? var.count : 0}"

  zone_id = "${coalesce(var.zone_id, "-")}"

  name = "${format("nat-gateway-%03d.%s", count.index + 1, coalesce(var.domain_name,
            join("", data.aws_route53_zone.mod.*.name)))}"

  type = "A"
  ttl  = 60

  records = ["${element(aws_nat_gateway.mod.*.public_ip, count.index)}"]

  depends_on = ["aws_nat_gateway.mod"]
}
