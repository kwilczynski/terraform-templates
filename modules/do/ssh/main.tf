resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "digitalocean_ssh_key" "mod" {
  name       = "${var.name}"
  count      = "${length(var.public_keys)}"
  public_key = "${file(element(var.public_keys, count.index))}"
  depends_on = ["null_resource.depends_on"]
}
