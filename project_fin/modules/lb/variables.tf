variable "sg_map" {
  description = "보안 그룹 맵"
  type        = map(string)
}
variable "target_group_arn" {
  description = "타겟 그룹 ARN"
  type        = string
}
variable "subnet_ids" {
  description = "서브넷 IDs"
  type        = list(string)
}
variable "certificate_arn" {
  description = "TLS 인증서의 arn 주소"
  type        = string
}
variable "load_balancer_type" {
  description = "로드 밸런서 타입"
  type        = string
  default     = "application"
}
variable "lb_name" {
  description = "로드 밸런서 이름"
  type        = string
  default     = "lb-web"
}
variable "internal" {
  description = "내부 로드 밸런서 생성 여부"
  type        = bool
  default     = false
}
variable "ip_address_type" {
  description = "로드 밸런서 IP 타입"
  type        = string
  default     = "ipv4"
}
variable "https_port" {
  description = "HTTPS 리스너 포트"
  type        = number
  default     = 443
}
variable "https_protocol" {
  description = "HTTPS 리스너 프로토콜"
  type        = string
  default     = "HTTPS"
}
variable "ssl_policy" {
  description = "로드 밸런서 SSL 정책"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-Res-PQ-2025-09"
}
variable "default_action_type" {
  description = "리스너 기본 액션 타입"
  type        = string
  default     = "forward"
}
