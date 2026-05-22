output "lb_dns_names" {
  value = [ aws_lb.wordpress.dns_name ]
}
