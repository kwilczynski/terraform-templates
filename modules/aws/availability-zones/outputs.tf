output "region" {
  value = "${data.null_data_source.region.outputs.value}"
}

output "count" {
  value = "${length(var.regions[data.null_data_source.region.outputs.value])}"
}

output "all" {
  value = ["${formatlist("%s%s", data.null_data_source.region.outputs.value,
              var.regions[data.null_data_source.region.outputs.value])}"]
}

output "available" {
  value = ["${split(",", coalesce(join("",
              data.null_data_source.available.*.outputs.value), join(",",
              formatlist("%s%s", data.null_data_source.region.outputs.value,
              var.regions[data.null_data_source.region.outputs.value]))))}"]
}

output "available_count" {
  value = "${length(split(",", data.null_data_source.available.outputs.value))}"
}
