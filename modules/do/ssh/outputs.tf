output "ids" {
  value = ["${digitalocean_ssh_key.mod.*.id}"]
}

output "names" {
  value = ["${digitalocean_ssh_key.mod.*.name}"]
}

output "public_keys" {
  value = ["${digitalocean_ssh_key.mod.*.public_key}"]
}

output "fingerprints" {
  value = ["${digitalocean_ssh_key.mod.*.fingerprint}"]
}
