output "id" {
  value = "${digitalocean_ssh_key.m.id}"
}

output "name" {
  value = "${digitalocean_ssh_key.m.name}"
}

output "public_key" {
  value = "${digitalocean_ssh_key.m.public_key}"
}

output "fingerprint" {
  value = "${digitalocean_ssh_key.m.fingerprint}"
}
