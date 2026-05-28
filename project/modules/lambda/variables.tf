variable "region_name" {
  description = "AWS 리전명"
  type = string
}
variable "subnet_ids" {
  description = "AWS VPC 서브넷 IDs"
  type = list(string)
}
variable "sg_map" {
  description = "보안 그룹 맵"
  type = map(string)
}
variable "db_init_id" {
  description = "db_init.sql 파일의 ID"
  type = string
}
variable "lambda_function_id" {
  description = "lambda_function.py 파일의 ID"
  type = string
}
variable "lambda" {
  description = "Lambda 함수정보"
  type = object({
    function_name = string
    runtime = string
    role = string
    handler = string
    vpc_config = object(
        {
            sg_names = list(string)
        }
    )
  })
}
variable "host" {
  type = string
}
variable "port" {
  type = number
  default = 3306
}
variable "user" {
  type = string
}
variable "password" {
  type = string
}
variable "db" {
  type = string
  default = ""
}
variable "rds_id" {
  type = string
}