variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name"   {}
variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
