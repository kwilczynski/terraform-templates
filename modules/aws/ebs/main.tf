resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_ebs_volume" "mod" {
  availability_zone = "${var.availability_zone}"

  encrypted = "${var.encrypted}"

  iops = "${var.iops}"
  size = "${var.size}"
  type = "${var.type}"

  kms_key_id = "${var.kms_key_id}"

  tags = "${merge(map(
    "Name",        "${format("%s-%s-ebs-volume", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}
