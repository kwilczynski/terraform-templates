output "image_id" {
  value = "${data.aws_ami.mod.image_id}"
}

output "name" {
  value = "${data.aws_ami.mod.name}"
}

output "creation_date" {
  value = "${data.aws_ami.mod.creation_date}"
}
