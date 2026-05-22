resource "aws_launch_template" "web" {
  update_default_version = true
  name = var.lt_web.name
  description = var.lt_web.description
  image_id = var.lt_web.image_id
  instance_type = var.lt_web.instance_type
  key_name = var.key_name

  iam_instance_profile {
    name = var.lt_web.iam_instance_profile.name
  }
  user_data = base64encode(file("../../project/files/${var.file_map.web_script.key}"))
}