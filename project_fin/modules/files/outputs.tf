output "db_init_filename" {
  description = "db_init.sql 파일의 경로"
  value       = local_file.db_init.filename
}
output "db_init_id" {
  description = "db_init.sql 파일의 ID"
  value       = local_file.db_init.id
}
output "lambda_function_id" {
  description = "lambda_function.py 파일의 ID"
  value       = local_file.lambda_function.id
}
output "web_script_content" {
  value = local_file.web_script.content
}
output "www_conf_filename" {
  value = local_file.www_conf.filename
}
output "config_php_filename" {
  value = local_file.config_php.filename
}
output "www_conf_content_md5" {
  value = md5(local_file.www_conf.content)
}
output "config_php_content_md5" {
  value = md5(local_file.config_php.content)
}