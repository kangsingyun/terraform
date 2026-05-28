output "lb_dns_names" {
  value = [aws_lb.web.dns_name]
}
