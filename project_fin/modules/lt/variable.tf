variable "lt_web" {
  type = object(
    {
      name          = string
      description   = string
      image_id      = string
      instance_type = string
      sg_names      = list(string)
    }
  )
}
variable "iam_role_name" {
  description = "AWS IAM 역할명 - 시작템플릿, S3 버킷"
  type        = string
}
variable "key_name" {
  description = "AWS 키페어 이름"
  type        = string
}
variable "web_script_content" {
  description = "web_script.sh "
  type        = string
}
variable "sg_map" {
  description = "보안 그룹 맵"
  type        = map(string)
}