variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "cidr_block" {}
variable "vpc_id"     {}

variable "comment" {
  default = ""
}

variable "force_destroy" {
  default = false
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
