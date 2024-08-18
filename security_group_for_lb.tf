resource "aws_security_group" "loadbalancer_sec_gr" {
  name        = "loadbalancer_sec_gr"
  description = "Allow inbound HTTP traffic"
  vpc_id      = aws_vpc.main_vpcs.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

