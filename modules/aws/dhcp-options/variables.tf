variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "vpc_id" {}

variable "region" {
  default = ""
}

variable "domain_name" {
  default = ""
}

variable "domain_name_servers" {
  default = ["AmazonProvidedDNS"]
}

variable "ntp_servers" {
  default = []
}

variable "tags" {
  default = {}
}

variable "depends_on" {
  default = []
}
