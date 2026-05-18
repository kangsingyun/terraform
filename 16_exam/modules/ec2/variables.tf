variable "ec2_web" {
  description = "EC2 인스턴스 - Web 서버들"
  type = object({
    ami = string
    instance_type = string
    associate_public_ip_address = bool
    sg_names = list(string)
  })
}
variable "key_name" {
  description = "키페어에 등록된 키이름"
  type = string
}
variable "public_subnet_ids" {
  description = "AWS VPC의 공인 서브넷 IDs"
  type = list(string)
}
variable "private_subnet_ids" {
  description = "AWS VPC의 사설 서브넷 IDs"
  type = list(string)
}
variable "sg_map" {
  description = "보안 그룹 맵"
  type = map(string)
}