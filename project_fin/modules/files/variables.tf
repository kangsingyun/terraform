variable "database" {
  description = "DataBase 초기화 관련 DB 정보"
  type = object({
    db_name  = string
    hostname = string
    username = string
    password = string
  })
}
variable "region_name" {
  description = "AWS 리전명"
  type        = string
}
variable "account_id" {
  description = "AWS Account ID"
  type        = string
}
variable "s3_subname" {
  description = "S3 Bucket subname"
  type        = string
}
variable "web_app_file" {
  description = "Web 어플리케이션 압축 파일명"
  type        = string
}
variable "file_map" {
  description = "생성될 파일 정보 맵"
  type = map(object({
    key = string
  }))
}
variable "cache_endpoint" {
  description = "Redis Cache 서버 endpoint address/port"
  type = object({
    address = string
    port    = number
  })
}
variable "rds_address" {
  type = string
}