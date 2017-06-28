variable "route_table_id" {}

variable "subnet_id" {
  default = ""
}

variable "destination_cidr_block" {
  default = ""
}

variable "vpc_peering_connection_id" {
  default = ""
}

variable "gateway_id" {
  default = ""
}

variable "nat_gateway_id" {
  default = ""
}

variable "instance_id" {
  default = ""
}

variable "network_interface_id" {
  default = ""
}

variable "depends_on" {
  default = []
}
