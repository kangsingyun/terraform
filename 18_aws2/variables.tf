variable "region" {
  description = "리전 코드"
  type        = string
}
variable "region_name" {
  description = "리전 이름"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC 대역대"
  type        = string
}
variable "subnet_bit" {
  description = "서브넷 비트수"
  type        = number
  default     = 8
}
variable "public_subnet_count" {
  description = "퍼블릭 서브넷 수"
  type        = number
  default     = 2
}
variable "private_subnet_count" {
  description = "프아리브 서브넷 수"
  type        = number
  default     = 2
}
variable "ami" {
  description = "EC2 AMI ID"
  type        = string
}
variable "instance_type" {
  description = "INSTANCE TYPE"
  type        = string
  default     = "t3.micro"
}
variable "key_algorithm" {
  description = "SSH KEY"
  type        = string
  default     = "ED25519"
}
variable "company_cidr" {
  description = "SSH ALLOW"
  type        = string
}