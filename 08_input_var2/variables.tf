variable "region"      { default = "ap-northeast-2" }
variable "region_name" { default = "seoul" }
variable "cidr_block"  { default = "10.0.0.0/16" }
variable "ACCESS_KEY"  { default = "" }
variable "SECRET_KEY"  { default = "" }

variable "security_groups" {
  type = list(object({
    name    = string
    desc    = string
    ingress = list(object({
      protocol  = string
      from_port = number
      to_port   = number
      cidr      = list(string)
    }))
    egress = list(object({
      protocol  = string
      from_port = number
      to_port   = number
      cidr      = list(string)
    }))
  }))
  default = [
    {
      name = "fw-ssh"
      desc = "fw allow - ssh"
      ingress = [
        { protocol = "tcp", from_port = 22, to_port = 22, cidr = ["1.0.0.0/8", "2.0.0.0/8", "3.0.0.0/8"] }
      ]
      egress = [
        { protocol = "-1", from_port = 0, to_port = 0, cidr = ["0.0.0.0/0"] }
      ]
    },
    {
      name = "fw-web"
      desc = "fw allow - web"
      ingress = [
        { protocol = "tcp", from_port = 80,  to_port = 80,  cidr = ["0.0.0.0/0"] },
        { protocol = "tcp", from_port = 443, to_port = 443, cidr = ["0.0.0.0/0"] }
      ]
      egress = [
        { protocol = "-1", from_port = 0, to_port = 0, cidr = ["0.0.0.0/0"] }
      ]
    },
    {
      name = "fw-db"
      desc = "fw allow - db"
      ingress = [
        { protocol = "tcp", from_port = 3306, to_port = 3306, cidr = ["10.2.1.0/24"] }
      ]
      egress = [
        { protocol = "-1", from_port = 0, to_port = 0, cidr = ["0.0.0.0/0"] }
      ]
    }
  ]
}