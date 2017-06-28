variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name"   {}
variable "vpc_id" {}

variable "propagating_vgws" {
  default = []
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
