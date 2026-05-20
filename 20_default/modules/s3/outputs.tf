output "s3_address_map" {
  value = {
    for k,v in aws_s3_object.files:
    k => "s3://${v.bucket}/${v.key}"
  }
}