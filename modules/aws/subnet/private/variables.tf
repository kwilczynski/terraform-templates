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

variable "nat_gateway_ids" {
  type = "list"
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
