resource "aws_security_group" "default" {
  name        = "${var.namespace}-${var.stage}-${var.stagename}-${var.instance}"
  description = "Managed by Terraform"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.namespace}-${var.stage}-${var.stagename}-${var.instance}"
  }
}

resource "aws_security_group_rule" "rule_egress" {
  count = "${length(var.access_egress)}"

  type     = "egress"
  protocol = "-1"

  from_port = "${element(keys(var.access_egress), count.index)}"
  to_port   = "${element(keys(var.access_egress), count.index)}"

  cidr_blocks = ["${var.access_egress[element(keys(var.access_egress), count.index)]}"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "rule_ingress_vpc" {
  type     = "ingress"
  protocol = "-1"

  from_port = "0"
  to_port   = "0"

  cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "rule_ingress_all" {
  count = "${length(var.access_ingress)}"

  type     = "ingress"
  protocol = "-1"

  from_port = "0"
  to_port   = "0"

  cidr_blocks = ["${var.access_ingress[element(keys(var.access_ingress), count.index)]}"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "rule_ingress_tcp" {
  count = "${length(var.access_ingress_tcp)}"

  from_port = "${element(keys(var.access_ingress_tcp), count.index)}"
  to_port   = "${element(keys(var.access_ingress_tcp), count.index)}"

  type     = "ingress"
  protocol = "TCP"

  cidr_blocks = ["${var.access_ingress_tcp[element(keys(var.access_ingress_tcp), count.index)]}"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "rule_ingress_udp" {
  count = "${length(var.access_ingress_udp)}"

  from_port = "${element(keys(var.access_ingress_udp), count.index)}"
  to_port   = "${element(keys(var.access_ingress_udp), count.index)}"

  type     = "ingress"
  protocol = "UDP"

  cidr_blocks = ["${var.access_ingress_udp[element(keys(var.access_ingress_udp), count.index)]}"]

  security_group_id = "${aws_security_group.default.id}"
}
