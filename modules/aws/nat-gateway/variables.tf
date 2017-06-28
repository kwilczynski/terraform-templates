variable "count" {
  default = 1
}

variable "subnet_ids" {
  type = "list"
}

variable "eip_allocation_ids" {
  default = []
}

variable "domain_name" {
  default = ""
}

variable "zone_id" {
  default = ""
}

variable "depends_on" {
  default = []
}
