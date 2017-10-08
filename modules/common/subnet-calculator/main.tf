data "null_data_source" "parser" {
  inputs = {
    to      = "${element(split("/", var.to), 1)}"
    netmask = "${element(split("/", var.cidr_block), 1)}"
  }
}

data "null_data_source" "integers" {
  inputs = {
    hosts   = "${pow(2, (32 - data.null_data_source.parser.outputs.to)) - 2}"
    subnets = "${pow(2, abs(data.null_data_source.parser.outputs.netmask -
                 data.null_data_source.parser.outputs.to))}"
  }
}

data "null_data_source" "networks" {
  count = "${var.count > 0 ? var.count : data.null_data_source.integers.outputs.subnets}"

  inputs = {
    value = "${cidrsubnet(var.cidr_block,
               abs(data.null_data_source.parser.outputs.netmask -
               data.null_data_source.parser.outputs.to),
               count.index)}"
  }
}

data "null_data_source" "odd" {
  count = "${var.count > 0 ? var.count : data.null_data_source.integers.outputs.subnets}"

  inputs = {
    value = "${count.index % 2 != 0
               ? element(data.null_data_source.networks.*.outputs.value, count.index)
               : ""}"
  }
}

data "null_data_source" "even" {
  count = "${var.count > 0 ? var.count : data.null_data_source.integers.outputs.subnets}"

  inputs = {
    value = "${count.index % 2 == 0
               ? element(data.null_data_source.networks.*.outputs.value, count.index)
               : ""}"
  }
}

resource "random_shuffle" "random" {
  count = "${var.shuffle ? 1 : 0}"

  input = [
    "${data.null_data_source.networks.*.outputs.value}"
  ]
}
