variable "sg_map" {
  description = "보안 그룹 맵"
  type = map(string)
}
variable "target_group_arn" {
  description = "타겟 그룹 ARN"
  type = string
}
variable "public_subnet_ids" {
  description = "공인 서브넷 IDs"
  type = list(string)
}