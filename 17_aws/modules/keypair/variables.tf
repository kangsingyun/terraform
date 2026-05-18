variable "algorithm" {
  description = "SSH 공개키 인증 알고리즘"
  type        = string
  default     = "RSA"
}
variable "rsa_bits" {
  description = "SSH 공개키 알고리즘 bits"
  type        = number
  default     = 2048
}