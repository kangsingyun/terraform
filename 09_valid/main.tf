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
data "aws_ec2_instance_types" "main" {
  filter {
    name   = "current-generation"
    values = ["true"]
  }
  filter {
    name   = "processor-info.supported-architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "instance-type"
    values = ["t3.*"]
  }
}
resource "aws_instance" "web1" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.subnet_ids[0]
  security_groups = [var.sg_map["web"]]
  tags = {
    Name = "${var.region}-web-1"
  }
}
resource "aws_instance" "web2" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.subnet_ids[1]
  security_groups = [var.sg_map["web"]]
  user_data       = <<-EOF
    #!/bin/bash

    useradd -G wheel admin
    echo "admin:${var.password}" | chpasswd
   EOF
  tags = {
    Name = "${var.region_name}-web-2"
  }
}
