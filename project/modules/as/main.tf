resource "aws_autoscaling_group" "web" {
  name = "auto-web"

  vpc_zone_identifier = var.public_subnet_ids
  availability_zone_distribution {
    capacity_distribution_strategy = "balanced-best-effort"
  }
  target_group_arns = [ var.target_group_arn ]
  health_check_type = "ELB"
  health_check_grace_period = 120

  min_size = 2
  max_size = 6
  desired_capacity = 2

  default_instance_warmup = 120

  launch_template {
    id = var.launch_template_id
    version = "$Latest"
  }
  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 120
  }
}
resource "aws_autoscaling_policy" "web" {
  name = "cpu-util-policy"
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 30
  }
}