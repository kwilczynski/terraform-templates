variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "peer_vpc_id" {}
variable "vpc_id"      {}

variable "auto_accept" {
  default = true
}

variable "peer_owner_id" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
