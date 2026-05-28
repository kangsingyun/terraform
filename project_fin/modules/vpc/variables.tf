variable "region" {
  description = "AWS 리전 코드"
  type        = string
}

variable "region_name" {
  description = "AWS 리전 이름"
  type        = string
}

variable "cidr_block" {
  description = "AWS VPC 전체 CIDR 네트워크 대역"
  type        = string
}

variable "count_of_public_subnets" {
  description = "공인 subnet의 수"
  type        = number
}

variable "count_of_private_subnets" {
  description = "사설 subnet의 수"
  type        = number
}

variable "subnet_bit" {
  description = "subnetting bit"
  type        = number
}

variable "count_of_az" {
  description = "VPC 가용영역(AZ)의 수"
  type        = number
}

variable "create_nat_gw" {
  description = "NAT 게이트웨이의 생성 여부"
  type        = bool
}
variable "route_cidr" {
  description = "퍼블릭/프라이빗 경로에 사용할 CIDR"
  type        = string
  default     = "0.0.0.0/0"
}
variable "eip_domain" {
  description = "EIP 도메인"
  type        = string
  default     = "vpc"
}
