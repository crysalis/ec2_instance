variable "instance" {}

variable "namespace" {}
variable "stagename" {}
variable "stage" {}

variable "domain" {
  "default" = "example.org"
}

variable "vpc_id" {}

variable "availability_zones" {
  "type" = "list"
}

variable "subnet_ids" {
  "type" = "list"
}

variable "eip" {
  "default" = "true"
}

variable "count" {
  "default" = "1"
}

variable "size" {
  "default" = "t2.micro"
}

variable "ami" {}

variable "key" {}

variable "access_ingress" {
  "type"    = "map"
  "default" = {}

  #"default" = {"0" = ["0.0.0.0/0"]}  # Allow any trafic from any host
}

variable "access_ingress_tcp" {
  "type"    = "map"
  "default" = {}

  #"default" = {"80" = ["0.0.0.0/0"]}  # Allow HTTP
}

variable "access_ingress_udp" {
  "type"    = "map"
  "default" = {}
}

variable "access_egress" {
  "type" = "map"

  "default" = {
    "0" = ["0.0.0.0/0"]
  }
}

variable "volume_size" {
  "default" = "8"
}

variable "volume_extra_size" {
  "default" = "0"
}

variable "volume_extra_type" {
  "default" = "standard"
}

variable "volume_extra_path" {
  "default" = "/dev/xvdb"
}

variable "iam_instance_profile" {
  "default" = ""
}

variable "associate_public_ip_address" {
  "default" = "false"
}

variable "user_data" {
  "default" = ""
}
