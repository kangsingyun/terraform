variable "account_id" {
    description = "AWS Account ID"
    type = string
}
variable "s3_subname" {
    description = "S3 Bucket subname"
    type = string
}
variable "iam_role_name" {
    description = "AWS IAM 역할 이름"
    type = string
}
variable "file_map" {
  type = map(object({
    key = string
  }))
}