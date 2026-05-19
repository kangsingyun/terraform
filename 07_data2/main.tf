terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_KEY
}
data "aws_availability_zones" "az_lists" {}
resource "aws_vpc" "main" {
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "${var.region_name}-vpc-main"
  }
}
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.main.id
  cidr_block = "10.2.0.0/24"
  availability_zone = data.aws_availability_zones.az_lists.names[0]
  tags = {
    Name = "${var.region_name}-subnet-public-1"
  }
}
resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.main.id
  cidr_block = "10.2.1.0/24"
  availability_zone = data.aws_availability_zones.az_lists.names[1]
  tags = {
    Name = "${var.region_name}-subnet-public-2"
  }
}
data "local_file" "file1" {
  filename = "${path.module}/cidr_block.txt"
}
output "xxx" {
  value = data.local_file.file1
}