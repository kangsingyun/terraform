terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_KEY
}
locals {
  az_names = data.aws_availability_zones.valid.names
}
data "aws_availability_zones" "valid" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.region_name}-vpc-main"
  }
}
resource "aws_subnet" "publics" {
  count = var.count_of_public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.subnet_bit, count.index)
  availability_zone = local.az_names[count.index % var.count_of_az]

  tags = {
    Name = "${var.region_name}-subnet-public-${count.index + 1}"
  }
}
resource "aws_subnet" "privates" {
  count = var.count_of_private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.subnet_bit, var.count_of_public_subnets + count.index)
  availability_zone = local.az_names[count.index % var.count_of_az]

  tags = {
    Name = "${var.region_name}-subnet-private-${count.index + 1}"
  }
}
resource "aws_security_group" "rules" {
  count = length(var.fw_rules)

  name        = var.fw_rules[count.index].name
  description = var.fw_rules[count.index].description
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = var.fw_rules[count.index].in.protocol
    from_port   = var.fw_rules[count.index].in.from_port
    to_port     = var.fw_rules[count.index].in.to_port
    cidr_blocks = var.fw_rules[count.index].in.cidr_blocks
  }

  egress {
    protocol    = var.fw_rules[count.index].out.protocol
    from_port   = var.fw_rules[count.index].out.from_port
    to_port     = var.fw_rules[count.index].out.to_port
    cidr_blocks = var.fw_rules[count.index].out.cidr_blocks
  }
  tags = {
    Name = var.fw_rules[count.index].name
    key  = var.fw_rules[count.index].key
  }
}
locals {
  sg_ids = {
    for obj in aws_security_group.rules:
      obj.tags.key => obj.id
  }
}

resource "aws_instance" "web1" {
  ami             = "ami-0b6cacee0430cdb2c"
  instance_type   = "t3.micro"
  key_name        = "seoul-ed25519-ksg-key"
  subnet_id       = aws_subnet.publics[0].id
  security_groups = [local.sg_ids["web"]]
  tags = {
    Name = "${var.region_name}-web-1"
  }
}
resource "aws_instance" "web2" {
  ami             = "ami-0b6cacee0430cdb2c"
  instance_type   = "t3.micro"
  key_name        = "seoul-ed25519-ksg-key"
  subnet_id       = aws_subnet.publics[1].id
  security_groups = [local.sg_ids["web"]]
  tags = {
    Name = "${var.region_name}-web-2"
  }
}