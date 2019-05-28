# Info

This module create desired `count` of instances with stated `ami` and `size`.

Instance would be named as stated in internal policy: https://wiki.playkot.com/pages/viewpage.action?pageId=26057214

If `eip` is set to "true", then EIP would be allocated. Otherwise instance should be placed in public subnet, specifying public `subnet_id`.

Full access would be granted from VPC's CIDR, from `access_ingress` and **to** `access_egress`.


# Usage

Create secgroup for VPC with full internal access between hosts.

```
module "app" {
  source = "git::ssh://git@gitlab.playkot.com/Ops/terraform/instance.git?ref=master"

  instance            = "app"

  namespace           = "myproject"
  stagename           = "main"
  stage               = "production"
  domain              = "example.org"

  eip                 = "false"

  volume_size         = "8"

  vpc_id              = "${module.vpc.vpc_id}"
  availability_zones  = ["eu-central-1a", "eu-central-1b"]
  subnet_ids          = "${module.dynamic_subnets.private_subnet_ids}"

  count               = "1"
  size                = "t2.micro"
  ami                 = "${var.app_ami_id}"
  key                 = "${var.key_name}"
}
```

# Improtant notices

- When changing the size, iops or type of an instance, there are considerations to be aware of that Amazon have written about this.
  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/limitations.html

## Input vars

| Variable             | Default       | Description                     | Required |
| ---                  | ---           | ---                             | ---      |
| `instance`           | ``            | Name of service                 | Yes |
| `namespace`          | ``            | Name of project/company         | Yes      |
| `envname`            | ``            | Name of environment             | Yes      |
| `stage`              | ``            | Name of stage: dev/prod/staging | Yes      |
| `domain`             | `example.org` | Domain                          | No       |
| `vpc_id`             | ``            | ID of VPC to create instance in | Yes      |
| `availability_zones` | ``            | List of zone names where to spread instances | Yes |
| `subnet_ids`         | ``            | List if subnet IDs to spread instances | Yes |
| `ami`                | ``            | AMI ID                          | Yes      |
| `key`                | ``            | Name of key to deploy with      | Yes      |
| `eip`                | `true`        | Allocate EIP or not             | No       |
| `count`              | `1`           | Number of instances to create   | No       |
| `size`               | `t2.micro`    | Instance plan                   | No       |
| `access_ingress`     | `{}`          | Ports and CIDRs to allow input  | No       |
| `access_egress`      | `{"0" = ["0.0.0.0/0"]}` | Same, but for output  | No       |
| `volume_size`        | `8`           |                                 | No       |
| `volume_extra_size`  | `0`           | Set to non-0 to add extra volume. | No       |
| `volume_extra_type`  | `standard`    |                                 | No       |
| `volume_extra_path`  | `/dev/xvdb`   |                                 | No       |
| `iam_instance_profile`| ``           | IAM profile to start with       | No       |

## Output values

| Name          | Description      |
| ---           | ---              |
| `id`          | ID of instance   |
| `private_ip`  | Private IP       |
| `secgroup_id` | ID of dedicated secgroup |
