output "key_name" {
  value = "${aws_key_pair.mod.key_name}"
}

output "algorithm" {
  value = "${tls_private_key.mod.algorithm}"
}

output "private_key_pem" {
  value = "${tls_private_key.mod.private_key_pem}"
}

output "public_key_pem" {
  value = "${tls_private_key.mod.public_key_pem}"
}

output "public_key" {
  value = "${chomp(var.public_key != ""
             ? join("", data.external.mod.*.result.public_key)
             : join("", tls_private_key.mod.*.public_key_openssh))}"
}

output "fingerprint" {
  value = "${aws_key_pair.mod.fingerprint}"
}
