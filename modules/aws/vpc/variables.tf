variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "cidr_block" {}

variable "zone_id" {
  default = ""
}

variable "instance_tenancy" {
  default = "default"
}

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_classiclink" {
  default = false
}

variable "tags" {
  default = {}
}
