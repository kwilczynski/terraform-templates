variable "vpc" {
  default = false
}

variable "instance" {
  default = ""
}

variable "network_interface" {
  default = ""
}

variable "associate_with_private_ip" {
  default = ""
}

variable "depends_on" {
  default = []
}
