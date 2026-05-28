resource "aws_autoscaling_group" "web" {
  name = var.name

  vpc_zone_identifier = var.public_subnet_ids
  availability_zone_distribution {
    capacity_distribution_strategy = var.capacity_distribution_strategy
  }
  target_group_arns         = [var.target_group_arn]
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  default_instance_warmup = var.default_instance_warmup

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }
  instance_maintenance_policy {
    min_healthy_percentage = var.min_healthy_percentage
    max_healthy_percentage = var.max_healthy_percentage
  }
}
resource "aws_autoscaling_policy" "web" {
  name                   = var.policy_name
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type            = var.policy_type
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }
    target_value = var.target_value
  }
}