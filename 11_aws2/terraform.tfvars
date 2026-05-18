region                   = "ap-northeast-2"
region_name              = "seoul"
cidr_block               = "10.2.0.0/16"
count_of_az              = 2
count_of_public_subnets  = 2
count_of_private_subnets = 2
subnet_bit               = 8
create_nat_gw            = false
sg_map = {
  web = {
    description = "allow http, https, ssh, icmp"
    ingress_rules = {
      icmp  = { protocol = "icmp", from_port = 8, to_port = 0, cidr_blocks = ["0.0.0.0/0"] }
      ssh   = { protocol = "tcp", from_port = 22, to_port = 22, cidr_blocks = ["0.0.0.0/0"] }
      http  = { protocol = "tcp", from_port = 80, to_port = 80, cidr_blocks = ["0.0.0.0/0"] }
      https = { protocol = "tcp", from_port = 443, to_port = 443, cidr_blocks = ["0.0.0.0/0"] }
    }
    egress_rules = {
      all = { protocol = "-1", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"] }
    }
  }

  db = {
    description = "allow ssh, mysql"
    ingress_rules = {
      ssh   = { protocol = "tcp", from_port = 22, to_port = 22, cidr_blocks = ["0.0.0.0/0"] }
      mysql = { protocol = "tcp", from_port = 3306, to_port = 3306, cidr_blocks = ["0.0.0.0/0"] }
    }
    egress_rules = {
      all = { protocol = "-1", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"] }
    }
  }

  redis = {
    description = "allow ssh, redis"
    ingress_rules = {
      ssh   = { protocol = "tcp", from_port = 22, to_port = 22, cidr_blocks = ["0.0.0.0/0"] }
      redis = { protocol = "tcp", from_port = 6379, to_port = 6379, cidr_blocks = ["0.0.0.0/0"] }
    }
    egress_rules = {
      all = { protocol = "-1", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"] }
    }
  }
}
ec2_web = {
  count            = 0
  ami              = "ami-035f4c601044a7af4"
  instance_type    = "t3.micro"
  key_name         = "seoul-ed25519-ksg-key"
  security_groups  = ["web"]
  on_public_subnet = true
}