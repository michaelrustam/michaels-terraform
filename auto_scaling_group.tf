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

