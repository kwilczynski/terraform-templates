variable "name" {}

variable "owners" {
  type = "list"
}

variable "root_device_type" {
  default = "ebs"
}
