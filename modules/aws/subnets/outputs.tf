output "public_ids" {
  value = ["${data.aws_subnet_ids.public.ids}"]
}

output "public_count" {
  value = "${length(data.aws_subnet_ids.public.ids)}"
}

output "private_ids" {
  value = ["${data.aws_subnet_ids.private.ids}"]
}

output "private_count" {
  value = "${length(data.aws_subnet_ids.private.ids)}"
}
