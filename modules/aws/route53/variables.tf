variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name" {}

variable "comment" {
  default = ""
}

variable "vpc_id" {
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
