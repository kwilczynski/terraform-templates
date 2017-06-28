variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "vpc_id" {}

variable "region" {
  default = ""
}

variable "cidr_blocks" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "map_public_ip_on_launch" {
  default = false
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
