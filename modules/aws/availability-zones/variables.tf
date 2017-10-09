variable "region" {
  default = ""
}

variable "exclude" {
  default = []
}

variable "shuffle" {
  default = false
}

variable "regions" {
  default = {
    us-east-1      = ["a", "b", "c", "d", "e", "f"]
    us-east-2      = ["a", "b", "c"]
    us-west-1      = ["a", "b", "c"]
    us-west-2      = ["a", "b", "c"]
    ca-central-1   = ["a", "b"]
    eu-west-1      = ["a", "b", "c"]
    eu-west-2      = ["a", "b"]
    eu-central-1   = ["a", "b", "c"]
    ap-northeast-1 = ["a", "b", "c"]
    ap-northeast-2 = ["a", "c"]
    ap-southeast-1 = ["a", "b"]
    ap-southeast-2 = ["a", "b", "c"]
    ap-south-1     = ["a", "b"]
    sa-east-1      = ["a", "b", "c"]
  }
}

variable "regions_long" {
  default = {
    us-east-1 = [
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1e",
      "us-east-1f"
    ]
    us-east-2 = [
      "us-east-2a",
      "us-east-2b",
      "us-east-2c"
    ]
    us-west-1 = [
      "us-west-1a",
      "us-west-1b",
      "us-west-1c"
    ]
    us-west-2 = [
      "us-west-2a",
      "us-west-2b",
      "us-west-2c"
    ]
    ca-central-1 = [
      "ca-central-1a",
      "ca-central-1b"
    ]
    eu-west-1 = [
      "eu-west-1a",
      "eu-west-1b",
      "eu-west-1c"
    ]
    eu-west-2 = [
      "eu-west-2a",
      "eu-west-2b"
    ]
    eu-central-1 = [
      "eu-central-1a",
      "eu-central-1b",
      "eu-central-1c"
    ]
    ap-northeast-1 = [
      "ap-northeast-1a",
      "ap-northeast-1b",
      "ap-northeast-1c"
    ]
    ap-northeast-2 = [
      "ap-northeast-2a",
      "ap-northeast-2c"
    ]
    ap-southeast-1 = [
      "ap-southeast-1a",
      "ap-southeast-1b"
    ]
    ap-southeast-2 = [
      "ap-southeast-2a",
      "ap-southeast-2b",
      "ap-southeast-2c"
    ]
    ap-south-1 = [
      "ap-south-1a",
      "ap-south-1b"
    ]
    sa-east-1 = [
      "sa-east-1a",
      "sa-east-1b",
      "sa-east-1c"
    ]
  }
}
