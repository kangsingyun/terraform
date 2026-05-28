output "domain_validation_option" {
  value = tolist(aws_acm_certificate.web.domain_validation_options)[0]
}
output "certificate_arn" {
  value = aws_acm_certificate.web.arn
}