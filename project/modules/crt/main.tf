resource "aws_acm_certificate" "web" {
  domain_name = "${var.hostname}.${var.domainname}"
  validation_method = "DNS"
}
resource "aws_acm_certificate_validation" "crt" {
  certificate_arn = aws_acm_certificate.web.arn
  validation_record_fqdns = [ var.crt_cname_fqdn ]
}