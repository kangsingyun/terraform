locals {
  az_names = data.aws_availability_zones.valid.names
}
data "aws_availability_zones" "valid" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = { Name = "${var.region_name}-vpc-main" }
}

resource "aws_subnet" "publics" {
  count             = var.count_of_public_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.subnet_bit, count.index)
  availability_zone = local.az_names[count.index % var.count_of_az]
  tags = { Name = "${var.region_name}-subnet-public-${count.index + 1}" }
}

resource "aws_subnet" "privates" {
  count             = var.count_of_private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.subnet_bit,var.count_of_public_subnets + count.index)
  availability_zone = local.az_names[count.index % var.count_of_az]
  tags = { Name = "${var.region_name}-subnet-private-${count.index + 1}" }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.region_name}-igw-main" }
}

resource "aws_eip" "nat_ips" {
  count  = var.create_nat_gw ? var.count_of_az : 0
  domain = "vpc"
  tags   = { Name = "${var.region_name}-nat-eip-${count.index + 1}" }
}

resource "aws_nat_gateway" "private_nat_gws" {
  count         = var.create_nat_gw ? var.count_of_az : 0
  allocation_id = aws_eip.nat_ips[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id
  tags          = { Name = "${var.region_name}-nat-gw-${count.index + 1}" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = { Name = "${var.region_name}-route-public" }
}

resource "aws_route_table" "with_nat_privates" {
  count  = var.create_nat_gw ? var.count_of_private_subnets : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat_gws[count.index].id
  }
  tags = { Name = "${var.region_name}-route-private-${count.index + 1}" }
}

resource "aws_route_table" "without_nat_privates" {
  count  = var.create_nat_gw ? 0 : var.count_of_private_subnets
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.region_name}-route-private-${count.index + 1}" }
}

resource "aws_route_table_association" "publics" {
  count          = var.count_of_public_subnets
  subnet_id      = aws_subnet.publics[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "privates" {
  count          = var.count_of_private_subnets
  subnet_id      = aws_subnet.privates[count.index].id
  route_table_id = var.create_nat_gw? aws_route_table.with_nat_privates[count.index].id: aws_route_table.without_nat_privates[count.index].id
}