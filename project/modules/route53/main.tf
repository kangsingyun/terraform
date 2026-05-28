data "aws_route53_zone" "main" {
  name = var.domainname
  private_zone = false
}
resource "aws_route53_record" "web" {
  zone_id = data.aws_route53_zone.main.id
  name = "${var.hostname}.${var.domainname}"
  records = var.lb_dns_names
  type = "CNAME"
  ttl = 60  
}
resource "aws_route53_record" "crt" {
  zone_id = data.aws_route53_zone.main.id
  name = var.domain_validation_option.resource_record_name
  type = var.domain_validation_option.resource_record_type
  records = [ var.domain_validation_option.resource_record_value ]
  ttl = 60
}