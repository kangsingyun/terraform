variable "launch_template_id" {
  description = "시작 템플릿의 ID"
  type        = string
}
variable "public_subnet_ids" {
  description = "AWS VPC 공인 서브넷 IDs"
  type        = list(string)
}
variable "target_group_arn" {
  description = "타겟 그룹의 ARN 주소"
  type        = string
}
variable "name" {
  description = "Auto Scaling Group 이름"
  type        = string
  default     = "auto-web"
}
variable "capacity_distribution_strategy" {
  description = "Auto Scaling 영역 배치 전략"
  type        = string
  default     = "balanced-best-effort"
}
variable "health_check_type" {
  description = "Auto Scaling 헬스 체크 타입"
  type        = string
  default     = "ELB"
}
variable "health_check_grace_period" {
  description = "Auto Scaling 헬스 체크 grace period"
  type        = number
  default     = 120
}
variable "min_size" {
  description = "Auto Scaling 그룹 최소 인스턴스 수"
  type        = number
  default     = 2
}
variable "max_size" {
  description = "Auto Scaling 그룹 최대 인스턴스 수"
  type        = number
  default     = 6
}
variable "desired_capacity" {
  description = "Auto Scaling 그룹 원하는 인스턴스 수"
  type        = number
  default     = 2
}
variable "default_instance_warmup" {
  description = "Auto Scaling 인스턴스 warmup 시간"
  type        = number
  default     = 120
}
variable "launch_template_version" {
  description = "시작 템플릿 버전"
  type        = string
  default     = "$Latest"
}
variable "min_healthy_percentage" {
  description = "Auto Scaling 최소 유지 헬시 비율"
  type        = number
  default     = 100
}
variable "max_healthy_percentage" {
  description = "Auto Scaling 최대 헬시 비율"
  type        = number
  default     = 120
}
variable "policy_name" {
  description = "Auto Scaling 정책 이름"
  type        = string
  default     = "cpu-util-policy"
}
variable "policy_type" {
  description = "Auto Scaling 정책 타입"
  type        = string
  default     = "TargetTrackingScaling"
}
variable "predefined_metric_type" {
  description = "Auto Scaling 타겟 추적 지표"
  type        = string
  default     = "ASGAverageCPUUtilization"
}
variable "target_value" {
  description = "Auto Scaling 타겟 CPU 값"
  type        = number
  default     = 30
}