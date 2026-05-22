variable "domainname" {
  description = "Route53 관리중인 도메인명"
  type = string
}
variable "lb_dns_names" {
  description = "로드밸런서의 DNS 이름들"
  type = list(string)
}