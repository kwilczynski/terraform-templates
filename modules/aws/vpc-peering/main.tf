data "aws_caller_identity" "mod" {
  count = "${var.peer_owner_id != "" ? 0 : 1}"
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_vpc_peering_connection" "mod" {
  peer_vpc_id = "${var.peer_vpc_id}"
  vpc_id      = "${var.vpc_id}"
  auto_accept = "${var.auto_accept}"

  peer_owner_id = "${coalesce(var.peer_owner_id, join("",
                     data.aws_caller_identity.mod.*.account_id))}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = "${merge(map(
    "Name",        "${format("%s-%s-%s-vpc-peering-connetion",
                      var.stack_name, var.vpc_id, var.peer_vpc_id)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}
