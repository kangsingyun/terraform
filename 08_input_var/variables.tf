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
  default = "10.0.0.0/16"
}
variable "ACCESS_KEY" {
  type    = string
  default = ""
}
variable "SECRET_KEY" {
  type    = string
  default = ""
}
variable "sg_ssh_name" {
  type    = string
  default = "fw-ssh"
}

variable "sg_ssh_desc" {
  type    = string
  default = "fw allow - ssh"
}

variable "sg_ssh_in_protocol" {
  type    = string
  default = "tcp"
}

variable "sg_ssh_in_from_port" {
  type    = number
  default = 22
}

variable "sg_ssh_in_to_port" {
  type    = number
  default = 22
}

variable "sg_ssh_in_cidr_blocks" {
  type    = list(string)
  default = ["1.0.0.0/8", "2.0.0.0/8", "3.0.0.0/8"]
}

variable "sg_ssh_out_protocol" {
  type    = string
  default = "-1"
}

variable "sg_ssh_out_from_port" {
  type    = number
  default = 0
}

variable "sg_ssh_out_to_port" {
  type    = number
  default = 0
}

variable "sg_ssh_out_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}