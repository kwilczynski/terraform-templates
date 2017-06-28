variable "vpc_id" {}

variable "public" {
  default = true
}

variable "private" {
  default = true
}

variable "depends_on" {
  default = []
}
