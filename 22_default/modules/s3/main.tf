resource "aws_s3_bucket" "wordpress" {
  bucket = "s3-${var.account_id}-${var.s3_subname}"
}
resource "aws_s3_bucket_policy" "wordpress" {
  bucket = aws_s3_bucket.wordpress.bucket
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.account_id}:role/${var.iam_role_name}" 
            },
            "Action": "s3:*",
            "Resource": [
                "${aws_s3_bucket.wordpress.arn}",
                "${aws_s3_bucket.wordpress.arn}/*"
            ]
        }
    ]
})
}
resource "aws_s3_object" "files" {
  for_each = var.file_map
  bucket = aws_s3_bucket.wordpress.bucket

  key = each.value.key
  source = "../../project/files/${each.value.key}"
}