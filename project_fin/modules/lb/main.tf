resource "aws_lb" "web" {
  load_balancer_type = var.load_balancer_type
  name               = var.lb_name
  internal           = var.internal
  ip_address_type    = var.ip_address_type
  security_groups    = [var.sg_map["lb"]]

  subnets = var.subnet_ids
}
/* resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn =  var.target_group_arn
  }
} */
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-PQ-2025-09"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

}