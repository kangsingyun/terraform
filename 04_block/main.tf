terraform {
  required_version = "~> 1.0"

  required_providers {
    local = {
      version = "~> 2.5.0"
    }
    aws = {
      version = "~> 5.0"
    }
  }
}

# AWS Provider 블록 추가
provider "aws" {
  region     = "ap-northeast-2"
  access_key = "AKIAXOLQ6XOI5MAINEZ5"
  secret_key = "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"
}
resource "aws_vpc" "main" {
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "seoul-vpc-1"
  }
}
resource "aws_subnet" "publics" {
    count = 4
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.2.${count.index}.0/24"

  tags = {
    Name = "seoul-subnet-public-${count.index + 1}"
  }
}
