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
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.region_name}-vpc-main"
  }
}
resource "aws_security_group" "ssh" {
  name        = var.sg_ssh_name
  description = var.sg_ssh_desc
  vpc_id      = aws_vpc.main.id
  ingress{
      protocol    = var.sg_ssh_in_protocol
      from_port   = var.sg_ssh_in_from_port
      to_port     = var.sg_ssh_in_to_port
      cidr_blocks = var.sg_ssh_in_cidr_blocks
    }
  egress{
      protocol    = var.sg_ssh_out_protocol
      from_port   = var.sg_ssh_out_from_port
      to_port     = var.sg_ssh_out_to_port
      cidr_blocks = var.sg_ssh_out_cidr_blocks
    }
  tags = {
    Name = var.sg_ssh_name
  }
}