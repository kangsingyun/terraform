data "archive_file" "db_init" {
  type        = "zip"
  source_dir  = "../${var.region_name}/source"
  output_path = "../${var.region_name}/db_init.zip"

  depends_on = [var.db_init_id, var.lambda_function_id]
}
resource "aws_lambda_function" "db_init" {
  function_name = var.lambda.function_name
  runtime       = var.lambda.runtime
  role          = var.lambda.role
  handler       = var.lambda.handler

  filename = data.archive_file.db_init.output_path

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [
      for name in var.lambda.vpc_config.sg_names :
      var.sg_map[name]
    ]
  }
}
resource "aws_lambda_invocation" "db_init" {
  function_name = aws_lambda_function.db_init.function_name
  input = jsonencode(
    {
      host     = var.host
      port     = var.port
      user     = var.user
      password = var.password
      db       = var.db
    }
  )
  triggers = {
    rds_id = var.rds_id
  }
}