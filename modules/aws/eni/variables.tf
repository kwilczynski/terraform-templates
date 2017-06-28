variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name"      {}
variable "subnet_id" {}

variable "description" {
  default = ""
}

variable "private_ips" {
  default = []
}

variable "private_ips_count" {
  default = 0
}

variable "security_groups" {
  default = []
}

variable "source_dest_check" {
  default = true
}

variable "tags" {
  default = {}
}

variable "instance_id" {
  default = ""
}

variable "device_index" {
  default = 0
}

variable "depends_on" {
  default = []
}
