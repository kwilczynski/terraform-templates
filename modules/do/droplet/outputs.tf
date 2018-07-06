output "id" {
  value = "${digitalocean_droplet.mod.*.id}"
}

output "name" {
  value = "${digitalocean_droplet.mod.*.name}"
}

output "region" {
  value = "${digitalocean_droplet.mod.*.region}"
}

output "ipv6" {
  value = "${digitalocean_droplet.mod.*.ipv6}"
}

output "ipv6_address" {
  value = "${digitalocean_droplet.mod.*.ipv6_address}"
}

output "ipv6_address_private" {
  value = "${digitalocean_droplet.mod.*.ipv6_address_private}"
}

output "ipv4_address" {
  value = "${digitalocean_droplet.mod.*.ipv4_address}"
}

output "ipv4_address_private" {
  value = "${digitalocean_droplet.mod.*.ipv4_address_private}"
}

output "locked" {
  value = "${digitalocean_droplet.mod.*.locked}"
}

output "status" {
  value = "${digitalocean_droplet.mod.*.status}"
}

output "tags" {
  value = "${digitalocean_droplet.mod.*.tags}"
}

output "volume_ids" {
  value = "${digitalocean_droplet.mod.*.volume_ids}"
}
