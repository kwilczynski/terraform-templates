variable "stack_name"  {}
variable "environment" {}
variable "version"     {}

variable "image_id" {}
variable "key_name" {}

variable "vpc_id" {
  default = ""
}

variable "region" {
  default = ""
}

variable "iam_instance_profile" {
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_groups" {
  default = []
}

variable "allowed_security_groups" {
  default = []
}

variable "allowed_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "allow_icmp" {
  default = false
}

variable "subnet_ids" {
  type = "list"
}

variable "cloud_config" {
  default = ""
}

variable "user_data" {
  default = ""
}

variable "additional_user_data" {
  default = ""
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = 0
}

variable "role" {
  default = "bastion"
}

variable "eip_allocation_id" {
  default = ""
}

variable "domain_name" {
  default = ""
}

variable "zone_id" {
  default = ""
}

variable "tags" {
  default = []
}

variable "depends_on" {
  default = []
}
