resource "aws_instance" "instance" {
  count = "${var.count}"

  availability_zone           = "${var.availability_zones[count.index % length(var.availability_zones)]}"
  instance_type               = "${var.size}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key}"
  vpc_security_group_ids      = ["${aws_security_group.default.id}"]
  subnet_id                   = "${var.subnet_ids[count.index % length(var.subnet_ids)]}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"

  iam_instance_profile = "${var.iam_instance_profile}"

  root_block_device {
    volume_size = "${var.volume_size}"
  }

  tags {
    group = "${var.namespace}-${var.stage}-${var.stagename}-${var.instance}"
    Name  = "${var.instance}${count.index + 1}.${var.stage}-${var.stagename}.${var.namespace}.${var.domain}"
    Env   = "${var.stage}"
  }
}

resource "aws_eip" "public_ip" {
  count = "${var.eip == true ? var.count : 0}"

  instance = "${element(aws_instance.instance.*.id, count.index)}"
  vpc      = true

  tags {
    Name = "${var.instance}${count.index + 1}.${var.stage}-${var.stagename}.${var.namespace}.${var.domain}"
  }
}
