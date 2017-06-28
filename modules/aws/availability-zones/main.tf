data "aws_region" "mod" {
  count = "${var.region != "" ? 0 : 1}"

  current = true
}

data "null_data_source" "region" {
  inputs = {
    value = "${coalesce(var.region, join("", data.aws_region.mod.*.name))}"
  }
}

data "null_data_source" "padding" {
  count = "${length(var.exclude) > 0 ? length(var.regions[
             data.null_data_source.region.outputs.value]) : 0}"

  inputs = {
    value = ""
  }
}

data "null_data_source" "indices" {
  count = "${length(var.exclude) > 0 ? length(var.regions[
             data.null_data_source.region.outputs.value]) : 0}"

  inputs = {
    value = "${count.index}"
  }
}

data "null_data_source" "filter" {
  count = "${length(var.exclude) > 0 ? length(var.regions[
             data.null_data_source.region.outputs.value]) : 0}"

  inputs = {
    value = "${index(split(",", length(element(var.exclude, count.index)) > 1
               ? join(",", var.regions_long[data.null_data_source.region.outputs.value])
               : join(",", var.regions[data.null_data_source.region.outputs.value])),
               element(var.exclude, count.index))}"
  }
}

data "null_data_source" "available" {
  count = "${length(var.exclude) > 0 ? 1 : 0}"

  inputs = {
    value = "${join(",", formatlist("%s%s", data.null_data_source.region.outputs.value,
               compact(values(merge(zipmap(data.null_data_source.indices.*.outputs.value,
               var.regions[data.null_data_source.region.outputs.value]),
               zipmap(data.null_data_source.filter.*.outputs.value,
               data.null_data_source.padding.*.outputs.value))))))}"
  }
}

resource "random_shuffle" "random" {
  count = "${var.shuffle ? 1 : 0}"

  input = [
    "${data.null_data_source.available.*.outputs.value}"
  ]
}
