region                   = "ap-northeast-2"
region_name              = "seoul"
cidr_block               = "10.2.0.0/16"
count_of_az              = 2
count_of_public_subnets  = 2
count_of_private_subnets = 2
subnet_bit               = 8
fw_rules = [
  {
    key = "web"
    name        = "fw-web"
    description = "allow traffic-http"
    in = {
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
    out = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  },
  {
    key = "ssh"
    name        = "fw-ssh"
    description = "allow traffic-ssh"
    in = {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
    }
    out = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  },
  {
    key = "db"
    name        = "fw-db"
    description = "allow traffic-mysql"
    in = {
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306
      cidr_blocks = ["10.2.0.0/16"]
    }
    out = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
]