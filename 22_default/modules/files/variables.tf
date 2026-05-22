variable "account_id" {
    description = "AWS Account ID"
    type = string
}
variable "s3_subname" {
    description = "S3 Bucket subname"
    type = string
}
variable "rds_address" {
    type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "file_map" {
  description = "생성될 파일 정보 맵"
  type = map(object({
    key = string
  }))
}
variable "database" {
  type = object({
    db_name = string
    hostname = string
    username = string
    password = string
  })
}
variable "cache_endpoint" {
  type = object({
    address = string
    port = number
  })
}