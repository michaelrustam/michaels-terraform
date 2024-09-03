resource "aws_autoscaling_group" "images_auto_scale_gr" {
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  launch_template {
    id      = aws_launch_template.team_images_launch_t.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.team_images.id]

  # tags = [
  #   {
  #     key = "Name"
  #     value = "images-instance"
  #   }
  # ]
}

resource "aws_autoscaling_group" "videos_auto_scale_gr" {
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  launch_template {
    id      = aws_launch_template.team_videos_launch_t.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.team_videos.id]
}

# CloudWatch Alarm for Videos Auto Scaling Group
resource "aws_cloudwatch_metric_alarm" "videos_cpu_high" {
  alarm_name                = "videos-cpu-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 75
  alarm_description         = "Triggers scaling up when CPU utilization exceeds 75%"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.videos_auto_scale_gr.name
  }

  alarm_actions = [aws_autoscaling_policy.videos_scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "videos_cpu_low" {
  alarm_name                = "videos-cpu-low"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 25
  alarm_description         = "Triggers scaling down when CPU utilization drops below 25%"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.videos_auto_scale_gr.name
  }

  alarm_actions = [aws_autoscaling_policy.videos_scale_down.arn]
}

# Scaling Policy for Videos Auto Scaling Group
resource "aws_autoscaling_policy" "videos_scale_up" {
  name                   = "videos-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.videos_auto_scale_gr.name
}

resource "aws_autoscaling_policy" "videos_scale_down" {
  name                   = "videos-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.videos_auto_scale_gr.name
}
