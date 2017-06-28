variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "name" {}

variable "destruction" {
  default = ""
}

variable "principal_arns" {
  default = []
}

variable "key_usage" {
  default = ""
}

variable "policy" {
  default = ""
}

variable "deletion_window_in_days" {
  default = 7
}

variable "is_enabled" {
  default = true
}

variable "enable_key_rotation" {
  default = false
}

variable "alias" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
