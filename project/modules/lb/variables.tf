variable "sg_map" {
  description = "보안 그룹 맵"
  type = map(string)
}
variable "target_group_arn" {
  description = "타겟 그룹 ARN"
  type = string
}
variable "subnet_ids" {
  description = "서브넷 IDs"
  type = list(string)
}
variable "certificate_arn" {
  description = "TLS 인증서의 arn 주소"
  type = string
}