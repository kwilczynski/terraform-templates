variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "vpc_id" {}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
