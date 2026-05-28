variable "launch_template_id" {
  description = "시작 템플릿의 ID"
  type = string
}
variable "public_subnet_ids" {
  description = "AWS VPC 공인 서브넷 IDs"
  type = list(string)
}
variable "target_group_arn" {
  description = "타겟 그룹의 ARN 주소"
  type = string
}