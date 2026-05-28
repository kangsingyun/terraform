resource "aws_lb_target_group" "web" {
  name             = var.tg_web.name
  port             = var.tg_web.port
  protocol         = var.tg_web.protocol
  protocol_version = var.tg_web.protocol_version
  ip_address_type  = var.tg_web.ip_address_type
  target_type      = var.tg_web.target_type
  vpc_id           = var.vpc_id

  health_check {
    path                = var.tg_web.health_check.path
    protocol            = var.tg_web.health_check.protocol
    port                = var.tg_web.health_check.port
    healthy_threshold   = var.tg_web.health_check.healthy_threshold
    unhealthy_threshold = var.tg_web.health_check.unhealthy_threshold
    timeout             = var.tg_web.health_check.timeout
    interval            = var.tg_web.health_check.interval
    matcher             = var.tg_web.health_check.matcher
  }
}
