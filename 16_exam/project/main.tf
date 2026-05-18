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
  region = local.main.region
}
locals {
  main = yamldecode(file("./variables.yaml"))
}

module "vpc" {
  source      = "../modules/vpc"
  region      = local.main.region
  region_name = local.main.region_name
  cidr_block  = local.main.cidr_block

  count_of_public_subnets  = local.main.count_of_public_subnets
  count_of_private_subnets = local.main.count_of_private_subnets
  subnet_bit               = local.main.subnet_bit
  count_of_az              = local.main.count_of_az
  create_nat_gw            = local.main.create_nat_gw
}
module "sg" {
  source = "../modules/sg"

  vpc_id = module.vpc.vpc_id
  sg_map = local.main.sg_map
}

module "keypair" {
  source = "../modules/keypair"

  algorithm = local.main.algorithm
}
module "ec2" {
  source = "../modules/ec2"

  ec2_web = local.main.ec2_web
  key_name = module.keypair.key.key_name
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  sg_map = module.sg.sg_map
  
}

resource "local_file" "key" {
  content = module.keypair.key.openssh
  filename = "${path.module}/id_${lower(module.keypair.key.algorithm)}"
}

