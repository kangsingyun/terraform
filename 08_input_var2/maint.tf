terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = { version = "~> 6.0" }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_KEY
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.region_name}-vpc-main"
  }
}

resource "aws_security_group" "sg" {
  count       = 3       
  name        = var.security_groups[count.index].name
  description = var.security_groups[count.index].desc
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.security_groups[count.index].ingress
    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr
    }
  }

  dynamic "egress" {
    for_each = var.security_groups[count.index].egress
    content {
      protocol    = egress.value.protocol
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      cidr_blocks = egress.value.cidr
    }
  }

  tags = { Name = var.security_groups[count.index].name }
}