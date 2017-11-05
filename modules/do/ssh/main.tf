resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "digitalocean_ssh_key" "m" {
  name       = "${var.name}"
  public_key = "${file(var.public_key)}"
  depends_on = ["null_resource.depends_on"]
}
