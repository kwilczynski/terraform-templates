variable "release" {
  default = "16.04"
}

variable "name" {
  default = "*/ubuntu-*-%s-amd64-server-*"
}

variable "owners" {
  default = ["099720109477"]
}
