variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "vpc_id" {}

variable "name" {
  default = ""
}

variable "zone_id" {
  default = ""
}

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
