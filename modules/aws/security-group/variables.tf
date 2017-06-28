variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name"   {}
variable "vpc_id" {}

variable "description" {
  default = ""
}

variable "allow_icmp" {
  default = false
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
