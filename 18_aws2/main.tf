terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = var.region
}
resource "tls_private_key" "my_key" {
  algorithm = var.key_algorithm
}
resource "aws_key_pair" "my_key" {
  key_name   = "terraform-${lower(var.key_algorithm)}-key"
  public_key = tls_private_key.my_key.public_key_openssh
}
resource "local_file" "private_key" {
  content  = tls_private_key.my_key.private_key_openssh
  filename = "${path.module}/id_${lower(var.key_algorithm)}"
}
data "aws_availability_zones" "available" {}

locals {
  az_names = data.aws_availability_zones.available.names
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.region_name}-vpc-main"
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.region_name}-igw-main"
  }
}
resource "aws_subnet" "publics" {
  count             = var.public_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_bit, count.index)
  availability_zone = local.az_names[count.index % length(local.az_names)]
  tags = {
    Name = "${var.region_name}-subnet-public-${count.index + 1}"
  }
}
resource "aws_subnet" "privates" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_bit, var.public_subnet_count + count.index)
  availability_zone = local.az_names[count.index % length(local.az_names)]
  tags = {
    Name = "${var.region_name}-subnet-privates-${count.index + 1}"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.region_name}-route-public"
  }
}
resource "aws_route_table_association" "publics" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.publics[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_security_group" "web" {
  name        = "fw-web"
  description = "Web Traffics - AnyWhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fw-web"
  }
}
resource "aws_security_group" "remote" {
  name        = "fw-remote"
  description = "remote access - only company"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.company_cidr]
  }
  tags = { Name = "fw-remote" }
}

resource "aws_security_group" "icmp" {
  name        = "fw-icmp"
  description = "ICMP Echo Requests"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "icmp"
    from_port   = 8
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fw-icmp"
  }
}

resource "aws_security_group" "out" {
  name        = "fw-out"
  description = "Outbound Traffics - all"
  vpc_id      = aws_vpc.main.id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fw-out"
  }
}

## EC2 인스턴스 (public 서브넷 수만큼 생성)
resource "aws_instance" "webs" {
  count                       = var.public_subnet_count
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.this.key_name
  subnet_id                   = aws_subnet.publics[count.index].id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.remote.id,
    aws_security_group.icmp.id,
    aws_security_group.out.id,
  ]

  tags = { Name = "web-server-${count.index + 1}" }
}