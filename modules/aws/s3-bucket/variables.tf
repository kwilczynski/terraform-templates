variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "bucket" {}

variable "region" {
  default = ""
}

variable "server_side_encryption" {
  default = "AES256"
}

variable "principal_arns" {
  default = []
}

variable "acl" {
  default = "private"
}

variable "policy" {
  default = ""
}

variable "force_destroy" {
  default = false
}

variable "versioning" {
  default = false
}

variable "logging" {
  default = []
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
