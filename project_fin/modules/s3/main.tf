resource "aws_s3_bucket" "web" {
  bucket = "s3-${var.account_id}-${var.s3_subname}"

  depends_on = [
    var.www_conf_filename, var.config_php_filename
  ]
}
resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.bucket
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Statement1",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.account_id}:role/${var.iam_role_name}"
        },
        "Action" : "s3:*",
        "Resource" : [
          "${aws_s3_bucket.web.arn}",
          "${aws_s3_bucket.web.arn}/*"
        ]
      }
    ]
  })
}
resource "aws_s3_object" "files" {
  for_each = var.web_files
  bucket   = aws_s3_bucket.web.bucket

  key         = each.value.key
  source      = "../${var.region_name}/web_files/${each.value.key}"
  source_hash = each.value.md5
}