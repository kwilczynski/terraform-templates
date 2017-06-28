data "external" "mod" {
  count = "${var.public_key == "" ? 0 : 1}"

  program = ["bash", "${path.module}/scripts/public-key.sh"]

  query = {
    public_key = "${var.public_key}"
  }
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "tls_private_key" "mod" {
  count = "${var.public_key != "" ? 0 : 1}"

  algorithm   = "${var.algorithm}"
  rsa_bits    = "${var.rsa_bits}"
  ecdsa_curve = "${var.ecdsa_curve}"
}

resource "aws_key_pair" "mod" {
  key_name   = "${coalesce(var.key_name, format("%s-key-pair", var.stack_name))}"
  public_key = "${chomp(var.public_key != ""
                  ? join("", data.external.mod.*.result.public_key)
                  : join("", tls_private_key.mod.*.public_key_openssh))}"

  depends_on = ["null_resource.depends_on"]
}
