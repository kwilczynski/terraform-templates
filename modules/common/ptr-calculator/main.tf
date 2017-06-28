data "null_data_source" "parser" {
  inputs = {
    host = "${element(split("/", var.host), 0)}"
    size = "${length(split(".", var.host))}"
  }
}

data "null_data_source" "ptr" {
  count = "${data.null_data_source.parser.outputs.size}"

  inputs = {
    ptr = "${element(split(".", data.null_data_source.parser.outputs.host),
             (data.null_data_source.parser.outputs.size - count.index) - 1)}"
  }
}
