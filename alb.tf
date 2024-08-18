resource "aws_lb_target_group" "team_images" {
  name        = "teamimagetg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpcs.id
  target_type = "instance"

}

resource "aws_lb_target_group" "team_videos" {
  name        = "teamvideotg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpcs.id
  target_type = "instance"

}

resource "aws_lb" "teamapplb" {
  name               = "teamapplb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer_sec_gr.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

}

resource "aws_lb_listener" "teamapplb_listener" {
  load_balancer_arn = aws_lb.teamapplb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "images_rule" {
  listener_arn = aws_lb_listener.teamapplb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.team_images.arn
  }
  condition {
    path_pattern {
      values = ["/itmemes/*"]
    }
  }

}

resource "aws_lb_listener_rule" "videos_rule" {
  listener_arn = aws_lb_listener.teamapplb_listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.team_videos.arn
  }

  condition {
    path_pattern {
      values = ["/videos/*"]
    }
  }
}

