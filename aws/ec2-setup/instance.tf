resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.machine_type
  vpc_security_group_ids = [aws_security_group.network_ports.id]


  tags = {
    name         = var.machine_name
    "created by" = var.author
    description  = var.tag-description
  }
}

resource "aws_lb_target_group" "unberry-ats-backend-dev" {
  name     = "unberry-ats-backend-dev"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_security_group.network_ports.vpc_id

  health_check {
    path = "/health"
  }

  tags = {
    Name = "unberry-ats-backend-dev"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.unberry-ats-backend-dev.arn
  target_id        = aws_instance.web.id
  port             = 80
}
