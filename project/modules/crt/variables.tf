variable "domainname" {
  description = "Route53 관리중인 도메인명"
  type = string
}
variable "hostname" {
  description = "호스트명"
  type = string
}
variable "crt_cname_fqdn" {
  description = "TLS 인증서 검증 FQDN"
  type = string
}