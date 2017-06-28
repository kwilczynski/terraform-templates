variable "stack_name"  {}

variable "algorithm" {
  default = "RSA"
}

variable "rsa_bits" {
  default = 4096
}

variable "ecdsa_curve" {
  default = "P384"
}

variable "public_key" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "depends_on" {
  default = []
}
