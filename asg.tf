resource "aws_autoscaling_group" "asg" {
  name                      = "${var.project_name}-ASG"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  # health_check_type         = "EC2"
  vpc_zone_identifier       = var.ec2_subnet_id

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  depends_on = [
    time_sleep.wait_for_efs_seconds,
  ]

}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  alb_target_group_arn   = aws_lb_target_group.tg.arn
}

resource "aws_autoscaling_policy" "asg_cpu_policy" {
  name                   = "${var.project_name}-ASG-Policy"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling" 

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}
