# creating security group
resource "aws_security_group" "network_ports" {
  #   name        = "from_terraform"
  #   description = "Security group entirely generated from terraform"

  # dynamic blocks terraform
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = port.value["name"]
      from_port   = port.value["port"]
      to_port     = port.value["port"]
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # allow traffic from everywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    name         = "${var.machine_name} SG"
    "created by" = var.author
    description  = var.tag-description
  }
}

output "vpc_id" {
  value = aws_security_group.network_ports.vpc_id
}
