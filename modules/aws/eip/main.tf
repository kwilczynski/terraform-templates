resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_eip" "mod" {
  vpc = "${var.vpc}"

  instance                  = "${var.instance}"
  network_interface         = "${var.network_interface}"
  associate_with_private_ip = "${var.associate_with_private_ip}"

  depends_on = ["null_resource.depends_on"]
}
