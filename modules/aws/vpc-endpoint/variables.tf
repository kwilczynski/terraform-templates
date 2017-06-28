variable "vpc_id" {}

variable "route_table_ids" {
  type = "list"
}

variable "service" {
  default = "s3"
}

variable "policy" {
  default = ""
}

variable "depends_on" {
  default = []
}
