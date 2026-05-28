variable "account_id" {
  description = "AWS Account ID"
  type        = string
}
variable "s3_subname" {
  description = "S3 Bucket subname"
  type        = string
}
variable "iam_role_name" {
  description = "AWS IAM 역할 이름"
  type        = string
}
variable "www_conf_filename" {
  type = string
}
variable "config_php_filename" {
  type = string
}
variable "www_conf_content_md5" {
  type = string
}
variable "config_php_content_md5" {
  type = string
}
variable "web_files" {
  description = "AWS S3 업로드 파일 정보"
  type = map(object({
    key = string
    md5 = string
  }))
}
variable "region_name" {
  type = string
}