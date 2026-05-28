resource "aws_launch_template" "web" {
  update_default_version = true
  name                   = var.lt_web.name
  description            = var.lt_web.description
  image_id               = var.lt_web.image_id
  instance_type          = var.lt_web.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [
    for name in var.lt_web.sg_names :
    var.sg_map[name]
  ]

  iam_instance_profile {
    name = var.iam_role_name
  }
  user_data = base64encode(var.web_script_content)
}