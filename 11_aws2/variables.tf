variable "ACCESS_KEY" {
  type = string
}
variable "SECRET_KEY" {
  type = string
}
variable "region" {
  type    = string
  default = "ap-northeast-2"
}
variable "region_name" {
  type    = string
  default = "seoul"
}
variable "cidr_block" {
  type    = string
  default = "10.2.0.0/16"
}
variable "count_of_az" {
  type = number
}
variable "subnet_bit" {
  type = number
}
variable "count_of_public_subnets" {
  type = number
}
variable "count_of_private_subnets" {
  type = number
}
variable "create_nat_gw" {
  type = bool
}
variable "sg_map" {
  type = map(object({
    description = string
    ingress_rules = map(object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    }))
    egress_rules = map(object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    }))
  }))
}
variable "ec2_web" {
  type = object({
    count            = number
    ami              = string
    instance_type    = string
    key_name         = string
    on_public_subnet = bool
    security_groups  = list(string)
  })
}