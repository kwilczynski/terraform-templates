variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name" {}

variable "enable_logging" {
  default = true
}

variable "assume_role_policy" {
  default = ""
}

variable "policy" {
  default = ""
}

variable "retention_in_days" {
  default = "14"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "eni_id" {
  default = ""
}

variable "traffic_type" {
  default = "ALL"
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
