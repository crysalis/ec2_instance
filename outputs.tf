output "id" {
  value = ["${aws_instance.instance.*.id}"]
}

output "private_ip" {
  value = ["${aws_instance.instance.*.private_ip}"]
}

output "public_ip" {
  value = ["${aws_eip.public_ip.*.public_ip}"]
}

output "secgroup_id" {
  value = "${aws_security_group.default.id}"
}
