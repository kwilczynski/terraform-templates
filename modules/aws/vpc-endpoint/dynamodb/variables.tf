variable "vpc_id" {}

variable "route_table_ids" {
  type = "list"
}

variable "policy" {
  default = ""
}

variable "depends_on" {
  default = []
}
