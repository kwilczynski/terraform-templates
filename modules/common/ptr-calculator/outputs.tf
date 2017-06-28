output "host" {
  value = "${data.null_data_source.parser.outputs.host}"
}

output "ptr" {
  value = "${format("%s.in-addr.arpa", join(".",
             slice(data.null_data_source.ptr.*.outputs.ptr,
             lookup(var.shift, var.type),
             data.null_data_source.parser.outputs.size)))}"
}
