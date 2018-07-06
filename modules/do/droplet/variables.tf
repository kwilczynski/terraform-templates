variable "depends_on" {
  default = []
}

variable "name" {}
variable "region" {}
variable "image" {}
variable "ssh_keys" {
  type = "list"
}

variable "count" {
  default = 1
}

variable "size" {
  default = "512mb"
}

variable "backups" {
  default = false
}

variable "ipv6" {
  default = false
}

variable "private_networking" {
  default = false
}

variable "tags" {
  default = []
}
