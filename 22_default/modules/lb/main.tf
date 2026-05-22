resource "aws_lb" "wordpress" {
  load_balancer_type = "application"
  name = "lb-wordpress"
  internal = false
  ip_address_type = "ipv4"
  security_groups = [var.sg_map["lb"]]

  subnets = var.public_subnet_ids
}
resource "aws_lb_listener" "wordpress" {
  load_balancer_arn = aws_lb.wordpress.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn =  var.target_group_arn
  }
}