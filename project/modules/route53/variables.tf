variable "domainname" {
  description = "Route53 관리중인 도메인명"
  type = string
}
variable "hostname" {
  description = "호스트명"
  type = string
}
variable "lb_dns_names" {
  description = "로드밸런서의 DNS 이름들"
  type = list(string)
}
variable "domain_validation_option" {
  description = "TLS 인증서 관련 검증 레코드 정보"
  type = object({
    domain_name = string
    resource_record_name = string
    resource_record_type = string
    resource_record_value = string
  })
  
}