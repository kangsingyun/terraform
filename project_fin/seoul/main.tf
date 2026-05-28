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
data "local_file" "test_board_tar_gz" {
  filename = "./web_files/${local.main.web_app_file}"
}
locals {
  main = yamldecode(file("${path.module}/variables.yaml"))
}


module "vpc" {
  source = "../modules/vpc"

  region                   = local.main.region
  region_name              = local.main.region_name
  cidr_block               = local.main.cidr_block
  count_of_public_subnets  = local.main.count_of_public_subnets
  count_of_private_subnets = local.main.count_of_private_subnets
  subnet_bit               = local.main.subnet_bit
  count_of_az              = local.main.count_of_az
  create_nat_gw            = local.main.create_nat_gw
  route_cidr               = local.main.vpc.route_cidr
  eip_domain               = local.main.vpc.eip_domain
}
module "sg" {
  source = "../modules/sg"

  vpc_id = module.vpc.vpc_id
  sg_map = local.main.sg_map
}
module "keypair" {
  source = "../modules/keypair"

  region_name = local.main.region_name
  algorithm   = local.main.algorithm
}
module "rds" {
  source = "../modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids
  sg_map             = module.sg.sg_map
  db_subnet_group    = local.main.db_subnet_group
  db_parameter_group = local.main.db_parameter_group
  rds_mariadb        = local.main.rds_mariadb
}
module "files" {
  source = "../modules/files"

  region_name    = local.main.region_name
  database       = local.main.database
  account_id     = local.main.account_id
  s3_subname     = local.main.s3_subname
  web_app_file   = local.main.web_app_file
  file_map       = local.main.file_map
  rds_address    = module.rds.rds_address
  cache_endpoint = module.cache.cache_endpoint
}
module "lambda" {
  source = "../modules/lambda"

  region_name = local.main.region_name
  subnet_ids  = module.vpc.private_subnet_ids
  sg_map      = module.sg.sg_map
  lambda      = local.main.lambda
  host        = module.rds.rds_address
  user        = local.main.rds_mariadb.username
  password    = local.main.rds_mariadb.password
  rds_id      = module.rds.rds_id
  #port
  #db 
  db_init_id         = module.files.db_init_id
  lambda_function_id = module.files.lambda_function_id
}
module "cache" {
  source = "../modules/cache"

  subnet_ids   = module.vpc.private_subnet_ids
  sg_map       = module.sg.sg_map
  cache_valkey = local.main.cache_valkey
}
module "lt" {
  source = "../modules/lt"

  lt_web             = local.main.lt_web
  key_name           = module.keypair.key_name
  iam_role_name      = local.main.iam_role_name
  web_script_content = module.files.web_script_content
  sg_map             = module.sg.sg_map
}
module "s3" {
  source = "../modules/s3"

  account_id             = local.main.account_id
  region_name            = local.main.region_name
  s3_subname             = local.main.s3_subname
  www_conf_filename      = module.files.www_conf_filename
  config_php_filename    = module.files.config_php_filename
  iam_role_name          = local.main.iam_role_name
  www_conf_content_md5   = module.files.www_conf_content_md5
  config_php_content_md5 = module.files.config_php_content_md5
  web_files = {
    web_app_file = {
      key = local.main.web_app_file
      md5 = data.local_file.test_board_tar_gz.content_md5
    }
    www_conf = {
      key = local.main.file_map.www_conf.key
      md5 = module.files.www_conf_content_md5
    }
    config_php = {
      key = local.main.file_map.config_php.key
      md5 = module.files.config_php_content_md5
    }
  }
}
/* module "ec2" {
  source = "../modules/ec2"

  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  lt_web_id = module.lt.lt_web_id
  sg_map = module.sg.sg_map
  web = local.main.web
}*/
module "tg" {
  source = "../modules/tg"

  vpc_id = module.vpc.vpc_id
  tg_web = local.main.tg_web

}
module "lb" {
  source = "../modules/lb"

  sg_map              = module.sg.sg_map
  target_group_arn    = module.tg.target_group_arn
  subnet_ids          = module.vpc.public_subnet_ids
  load_balancer_type  = local.main.lb.load_balancer_type
  lb_name             = local.main.lb.name
  internal            = local.main.lb.internal
  ip_address_type     = local.main.lb.ip_address_type
  https_port          = local.main.lb.https_port
  https_protocol      = local.main.lb.https_protocol
  ssl_policy          = local.main.lb.ssl_policy
  default_action_type = local.main.lb.default_action_type
  certificate_arn     = module.crt.certificate_arn
}
module "route53" {
  source = "../modules/route53"

  domainname               = local.main.domainname
  hostname                 = local.main.hostname
  lb_dns_names             = module.lb.lb_dns_names
  record_type              = local.main.route53.record_type
  record_ttl               = local.main.route53.record_ttl
  private_zone             = local.main.route53.private_zone
  domain_validation_option = module.crt.domain_validation_option
}
module "as" {
  source = "../modules/as"

  launch_template_id             = module.lt.lt_web_id
  public_subnet_ids              = module.vpc.public_subnet_ids
  target_group_arn               = module.tg.target_group_arn
  name                           = local.main.as.name
  capacity_distribution_strategy = local.main.as.capacity_distribution_strategy
  health_check_type              = local.main.as.health_check_type
  health_check_grace_period      = local.main.as.health_check_grace_period
  min_size                       = local.main.as.min_size
  max_size                       = local.main.as.max_size
  desired_capacity               = local.main.as.desired_capacity
  default_instance_warmup        = local.main.as.default_instance_warmup
  launch_template_version        = local.main.as.launch_template_version
  min_healthy_percentage         = local.main.as.min_healthy_percentage
  max_healthy_percentage         = local.main.as.max_healthy_percentage
  policy_name                    = local.main.as.policy_name
  policy_type                    = local.main.as.policy_type
  predefined_metric_type         = local.main.as.predefined_metric_type
  target_value                   = local.main.as.target_value
}
module "crt" {
  source = "../modules/crt"

  domainname        = local.main.domainname
  hostname          = local.main.hostname
  crt_cname_fqdn    = module.route53.crt_cname_fqdn
  validation_method = local.main.crt.validation_method
}