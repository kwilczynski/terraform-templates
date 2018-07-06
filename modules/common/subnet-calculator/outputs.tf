output "cidr_block" {
  value = "${var.cidr_block}"
}

output "ptr" {
  value = "${format("%s.%s.in-addr.arpa", element(split(".", var.cidr_block), 1),
             element(split(".", var.cidr_block), 0))}"
}

output "address" {
  value = "${cidrhost(var.cidr_block, 0)}"
}

output "netmask" {
  value = "${cidrnetmask(var.cidr_block)}"
}

output "hosts" {
  value = "${data.null_data_source.integers.outputs.hosts}"
}

output "subnets" {
  value = "${data.null_data_source.integers.outputs.subnets}"
}

output "all" {
  value = ["${data.null_data_source.networks.*.outputs.value}"]
}

output "random" {
  value = ["${random_shuffle.random.*.result}"]
}

output "odd" {
  value = ["${compact(data.null_data_source.odd.*.outputs.value)}"]
}

output "even" {
  value = ["${compact(data.null_data_source.even.*.outputs.value)}"]
}

output "halve_1" {
  value = ["${slice(data.null_data_source.networks.*.outputs.value, 0,
              length(data.null_data_source.networks.*.outputs.value) / 2)}"]
}

output "halve_2" {
  value = ["${slice(data.null_data_source.networks.*.outputs.value,
              length(data.null_data_source.networks.*.outputs.value) / 2,
              length(data.null_data_source.networks.*.outputs.value))}"]
}
