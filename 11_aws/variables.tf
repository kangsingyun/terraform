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
variable "fw_rules" {
  type = list(object({
    key         = string
    name        = string
    description = string
    in = object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    })
    out = object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    })
  }))
}
