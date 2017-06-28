variable "host" {}

variable "type" {
  default = "host"
}

variable "shift" {
  default = {
    host    = 0
    subnet  = 1
    network = 2
  }
}
