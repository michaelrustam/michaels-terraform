resource "aws_launch_template" "team_images_launch_t" {
  name_prefix   = "team_images_launch_t"
  image_id      = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "team_images_instance"
    }
  }
}

resource "aws_launch_template" "team_videos_launch_t" {
  name_prefix   = "team_videos_launch_t"
  image_id      = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "team_videos_instance"
    }
  }
}

