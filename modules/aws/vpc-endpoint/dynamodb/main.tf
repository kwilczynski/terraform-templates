module "vpc_endpoint" {
  source = "../"

  service = "dynamodb"

  vpc_id          = "${var.vpc_id}"
  route_table_ids = ["${var.route_table_ids}"]
  policy          = "${var.policy}"

  depends_on = ["${var.depends_on}"]
}
