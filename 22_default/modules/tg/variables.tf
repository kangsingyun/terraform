variable "vpc_id" {
  description = "AWS VPC ID"
  type = string
}
variable "instance_ids" {
  description = "EC2 인스턴스 IDs"
  type = list(string)
}
variable "tg_web" {
  description = "타겟 그룹"
  type = object({
    name             = string
    port             = number
    protocol         = string
    protocol_version = string
    ip_address_type  = string
    target_type      = string
    health_check = object({
      path                = string
      protocol            = string
      port                = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout             = number
      interval            = number
      matcher             = string
    })
  })
}