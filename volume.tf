resource "aws_volume_attachment" "ebs_att" {
  count = "${var.volume_extra_size != 0 ? var.count : 0}"

  device_name = "${var.volume_extra_path}"

  volume_id   = "${aws_ebs_volume.extra.id}"
  instance_id = "${element(aws_instance.instance.*.id, count.index)}"
}

resource "aws_ebs_volume" "extra" {
  count = "${var.volume_extra_size != 0 ? var.count : 0}"

  availability_zone = "${var.availability_zones[count.index % length(var.availability_zones)]}"
  type              = "${var.volume_extra_type}"
  size              = "${var.volume_extra_size}"

  tags {
    Name = "${var.instance}${count.index + 1}.${var.stage}-${var.stagename}.${var.namespace}.${var.domain}"
  }
}
