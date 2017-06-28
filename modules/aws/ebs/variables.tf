variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name"              {}
variable "availability_zone" {}
variable "size"              {}

variable "encrypted" {
  default = false
}

variable "iops" {
  default = 0
}

variable "type" {
  default = "gp2"
}

variable "kms_key_id" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
