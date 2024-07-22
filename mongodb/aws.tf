resource "aws_vpc" "vpc-mongodb-aws-terraform-rnd" {
  cidr_block = var.aws_vpc_cidr_block

  tags = {
    Name = "vpc-mongodb-aws-terraform-rnd-cp"
  }
}

resource "aws_security_group" "sg-mongodb-aws-terraform-rnd" {
  vpc_id = aws_vpc.vpc-mongodb-aws-terraform-rnd.id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-mongodb-aws-terraform-rnd-cp"
  }
}
