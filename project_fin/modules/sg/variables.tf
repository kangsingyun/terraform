variable "vpc_id" {
  description = "AWS VPC의 ID"
  type        = string
}

variable "sg_map" {
  description = "보안 그룹 map"
  type = map(object(
    {
      description = string
      ingress_rules = map(object(
        {
          protocol    = string
          from_port   = number
          to_port     = number
          cidr_blocks = list(string)
        }
      ))
      egress_rules = map(object(
        {
          protocol    = string
          from_port   = number
          to_port     = number
          cidr_blocks = list(string)
        }
      ))
    }
  ))
}