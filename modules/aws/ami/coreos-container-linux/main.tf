module "ami" {
  source = "../"

  name   = "${format(var.name, var.release)}"
  owners = ["${var.owners}"]
}
