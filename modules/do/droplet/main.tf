resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "digitalocean_droplet" "m" {
  count = "${var.count}"

  name               = "${var.count > 1 ? format("%s-0%d", var.name, count.index) : var.name}"
  image              = "${var.image}"
  size               = "${var.size}"
  backups            = "${var.backups}"
  ipv6               = "${var.ipv6}"
  private_networking = "${var.private_networking}"
  region             = "${var.region}"
  ssh_keys           = ["${var.ssh_keys}"]
  tags               = "${var.tags}"
}
