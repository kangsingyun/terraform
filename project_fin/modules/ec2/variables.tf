variable "public_subnet_ids" {
  description = "AWS VPC의 공인 서브넷 IDs"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "AWS VPC의 사설 서브넷 IDs"
  type        = list(string)
}

variable "lt_web_id" {
  description = "시작 템플릿 - web"
  type        = string
}
variable "web" {
  description = "웹 서버의 정보"
  type = object({
    count    = number
    sg_names = list(string)
  })
}
variable "sg_map" {
  description = "보안 그룹 맵"
  type        = map(string)
}
