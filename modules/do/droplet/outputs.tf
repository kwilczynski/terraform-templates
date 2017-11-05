output "id" {
  value = "${digitalocean_droplet.m.*.id}"
}

output "name" {
  value = "${digitalocean_droplet.m.*.name}"
}

output "region" {
  value = "${digitalocean_droplet.m.*.region}"
}

output "ipv6" {
  value = "${digitalocean_droplet.m.*.ipv6}"
}

output "ipv6_address" {
  value = "${digitalocean_droplet.m.*.ipv6_address}"
}

output "ipv6_address_private" {
  value = "${digitalocean_droplet.m.*.ipv6_address_private}"
}

output "ipv4_address" {
  value = "${digitalocean_droplet.m.*.ipv4_address}"
}

output "ipv4_address_private" {
  value = "${digitalocean_droplet.m.*.ipv4_address_private}"
}

output "locked" {
  value = "${digitalocean_droplet.m.*.locked}"
}

output "status" {
  value = "${digitalocean_droplet.m.*.status}"
}

output "tags" {
  value = "${digitalocean_droplet.m.*.tags}"
}

output "volume_ids" {
  value = "${digitalocean_droplet.m.*.volume_ids}"
}
