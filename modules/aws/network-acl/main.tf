data "aws_vpc" "mod" {
  id = "${var.vpc_id}"
}

resource "null_resource" "depends_on" {
  triggers {
    depends_on = "${join("", var.depends_on)}"
  }
}

resource "aws_network_acl" "mod" {
  vpc_id = "${var.vpc_id}"

  subnet_ids = ["${var.subnet_ids}"]

  tags = "${merge(map(
    "Name",        "${format("%s-%s-network-acl", var.stack_name, var.name)}",
    "StackName",   "${var.stack_name}",
    "Environment", "${var.environment}",
    "Version",     "${var.version}"
  ), var.tags)}"

  depends_on = ["null_resource.depends_on"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_icmp_echo" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 10
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 8
  icmp_code = -1

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_icmp_echo_reply" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 11
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 0
  icmp_code = -1

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_icmp_destination_unreachable" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 12
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 3
  icmp_code = -1

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_icmp_source_quench" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 13
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 4
  icmp_code = -1

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_icmp_time_exceeded" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 14
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 11
  icmp_code = -1

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_dns_tcp" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 100
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 53
  to_port   = 53

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_dns_udp" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 101
  rule_action = "allow"

  protocol   = "udp"
  cidr_block = "0.0.0.0/0"

  from_port = 53
  to_port   = 53

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_time" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 102
  rule_action = "allow"

  protocol   = "udp"
  cidr_block = "0.0.0.0/0"

  from_port = 123
  to_port   = 123

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_ssh" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 200
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 22
  to_port   = 22

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_http" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 201
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_https" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 202
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_tcp_ephemeral_ports" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 900
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 1024
  to_port   = 65535

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_ingress_allow_udp_ephemeral_ports" {
  network_acl_id = "${aws_network_acl.mod.id}"

  rule_number = 1000
  rule_action = "allow"

  protocol   = "udp"
  cidr_block = "0.0.0.0/0"

  from_port = 1024
  to_port   = 65535

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_icmp_echo" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 10
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 8
  icmp_code = -1
  
  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_icmp_echo_reply" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 11
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 0
  icmp_code = -1
  
  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_icmp_destination_unreachable" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 12
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 3
  icmp_code = -1
  
  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_icmp_source_quench" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 13
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 4
  icmp_code = -1
  
  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_icmp_time_exceeded" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 14
  rule_action = "allow"

  protocol   = "icmp"
  cidr_block = "0.0.0.0/0"

  icmp_type = 11
  icmp_code = -1

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_dns_tcp" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 100
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 53
  to_port   = 53

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_dns_udp" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 101
  rule_action = "allow"

  protocol   = "udp"
  cidr_block = "0.0.0.0/0"

  from_port = 53
  to_port   = 53

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_time" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 102
  rule_action = "allow"

  protocol   = "udp"
  cidr_block = "0.0.0.0/0"

  from_port = 123
  to_port   = 123

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_ssh" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 200
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "${data.aws_vpc.mod.cidr_block}"

  from_port = 22
  to_port   = 22

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_http" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 201
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_https" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 202
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_tcp_ephemeral_ports" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 900
  rule_action = "allow"

  protocol   = "tcp"
  cidr_block = "0.0.0.0/0"

  from_port = 1024
  to_port   = 65535

  depends_on = ["aws_network_acl.mod"]
}

resource "aws_network_acl_rule" "rule_egress_allow_udp_ephemeral_ports" {
  network_acl_id = "${aws_network_acl.mod.id}"

  egress = true

  rule_number = 1000
  rule_action = "allow"

  protocol   = "udp"
  cidr_block = "0.0.0.0/0"

  from_port = 1024
  to_port   = 65535
  
  depends_on = ["aws_network_acl.mod"]
}
