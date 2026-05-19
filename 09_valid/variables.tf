variable "region" {
  type    = string
  default = "ap-northeast-2"
}
variable "region_name" {
  type    = string
  default = "seoul"
}
variable "ACCESS_KEY" {
  type = string
}
variable "SECRET_KEY" {
  type = string
}
variable "ami" {
  type = string
  validation {
    condition     = can(regex("^ami-[0-9a-f]{17}", var.ami))
    error_message = "AWS EC2 ami 이미지명으로 유효하지 않습니다."
  }
  default = "ami-0b6cacee0430cdb2c"
}
variable "instance_type" {
  type = string
  validation {
    condition     = contains(data.aws_ec2_instance_types.main.instance_types, var.instance_type)
    error_message = "AWS EC2 인스턴스 타입으로 유효하지 않습니다."
  }
  default = "t3.micro"
}
variable "key_name" {
  type    = string
  default = "seoul-ed25519-ksg-key"
}
variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-083fd686e5e9d6ee6", "subnet-0f9d6729e593609dc"]
}
variable "sg_map" {
  type = map(string)
  default = {
    default = "sg-0e600d699195f27d5"
    web     = "sg-044cd185d2791d25f"
  }
}
variable "password" {
  type    = string
  default = "P@ssw0rd123"
  sensitive = true
}