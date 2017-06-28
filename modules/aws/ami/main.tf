data "aws_ami" "mod" {
  most_recent = true

  owners = [
    "${var.owners}"
  ]

  filter {
    name   = "name"
    values = [
      "${var.name}"
    ]
  }

  filter {
    name   = "architecture"
    values = [
      "x86_64"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  filter {
    name   = "root-device-type"
    values = [
      "${var.root_device_type}"
    ]
  }
}
