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
resource "aws_security_group" "sg_map" {
  for_each = var.sg_map

  name        = "fw-${each.key}"
  description = each.value.description
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
      protocol    = egress.value.protocol
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "fw-${each.key}"
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.region_name}-igw-main"
  }
}
resource "aws_eip" "nat_ips" {
  count  = var.create_nat_gw ? var.count_of_az : 0
  domain = "vpc"
  tags = {
    Name = "${var.region_name}-nat-eip-${count.index + 1}"
  }
}
resource "aws_nat_gateway" "private_nat_gws" {
  count = var.create_nat_gw ? var.count_of_az : 0

  allocation_id = aws_eip.nat_ips[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id
  tags = {
    Name = "${var.region_name}-nat-gw-${count.index + 1}"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.region_name}-route-public"
  }
}
resource "aws_route_table_association" "publics" {
  count = var.count_of_public_subnets
  subnet_id = aws_subnet.publics[count.index].id
  route_table_id = aws_route_table.public.id
}
# NAT O - route 포함
resource "aws_route_table" "privates_with_nat" {
  count  = var.create_nat_gw ? var.count_of_private_subnets : 0
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat_gws[count.index].id
  }

  tags = {
    Name = "${var.region_name}-route-private-${count.index + 1}"
  }
}

# NAT X - route 없음
resource "aws_route_table" "privates_without_nat" {
  count  = var.create_nat_gw ? 0 : var.count_of_private_subnets
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.region_name}-route-private-${count.index + 1}"
  }
}

# association - 조건에 따라 둘 중 하나 참조
resource "aws_route_table_association" "privates" {
  count = var.count_of_private_subnets

  subnet_id      = aws_subnet.privates[count.index].id
  route_table_id = var.create_nat_gw ? aws_route_table.privates_with_nat[count.index].id : aws_route_table.privates_without_nat[count.index].id
}
resource "aws_instance" "webs" {
  count = var.ec2_web.count
  ami = var.ec2_web.ami
  instance_type = var.ec2_web.instance_type
  key_name = var.ec2_web.key_name
  subnet_id = ( 
    var.ec2_web.on_public_subnet 
    ? aws_subnet.publics[count.index % length(aws_subnet.publics)].id 
    : aws_subnet.privates[count.index % length(aws_subnet.privates)].id 
  )

  associate_public_ip_address = var.ec2_web.on_public_subnet
  security_groups = [
    for name in var.ec2_web.security_groups : 
    aws_security_group.sg_map[name].id
  ]
  tags = {
    Name = "${var.region_name}-ec2-web-${count.index + 1}"
  }
}
