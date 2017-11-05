output "name" {
  value = "${data.digitalocean_image.d.name}"
}

output "image" {
  value = "${data.digitalocean_image.d.image}"
}

output "min_disk_size" {
  value = "${data.digitalocean_image.d.min_disk_size}"
}

output "private" {
  value = "${data.digitalocean_image.d.private}"
}

output "regions" {
  value = "${data.digitalocean_image.d.regions}"
}

output "size_gigabytes" {
  value = "${data.digitalocean_image.d.size_gigabytes}"
}

output "type" {
  value = "${data.digitalocean_image.d.type}"
}
