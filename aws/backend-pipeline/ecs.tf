# resource "aws_ecs_cluster" "ecs" {
#   name = var.project_name

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }

# resource "aws_iam_role" "cluster_role" {
#   count = var.ecs_role != "" ? 0 : 1
#   name  = "${var.project_name}-ecs-role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Principal" : {
#           "Service" : "ec2.amazonaws.com"
#         },
#         "Action" : "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_ecs_task_definition" "task_definition" {
#   family                   = "${var.project_name}-${var.env}"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   execution_role_arn       = var.ecs_role != "" ? var.ecs_role : aws_iam_role.cluster_role[0].arn
#   cpu                      = 1024
#   memory                   = 2048

#   container_definitions = jsonencode([
#     {
#       name : "backend-server"
#       image     = "${aws_ecr_repository.ecr_repo.repository_url}"
#       cpu       = 1024
#       memory    = 512
#       essential = true
#       portMappings = [
#         {
#           containerPort = var.port
#           hostPort      = var.port
#         }
#       ]
#       environmentFiles = [
#         {
#           value = "${var.env_file_arn}"
#           type  = "s3"
#         }
#       ]
#       logConfiguration = {
#         logDriver = "awslogs"
#         options = {
#           "awslogs-region"        = var.region
#           "awslogs-group"         = "/ecs/${var.project_name}-log-group"
#           "awslogs-stream-prefix" = "ecs"
#         }

#       }
#     }
#   ])

#   runtime_platform {
#     operating_system_family = "WINDOWS_SERVER_2019_CORE"
#     cpu_architecture        = "X86_64"
#   }
# }

# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "${var.project_name}-vpc"
#   }
# }

# data "aws_vpc" "selected" {
#   filter {
#     name   = "tag:Name"
#     values = ["${var.project_name}-vpc"]
#   }
# }

# data "aws_subnets" "selected" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.selected.id]
#   }
# }
# resource "aws_lb_target_group" "ecs-target-group" {
#   name        = "${var.project_name}-target-group"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.main.id
#   target_type = "ip"

#   health_check {
#     interval            = 30
#     path                = "/health"
#     protocol            = "HTTP"
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#   }

# }

# resource "aws_security_group" "network_ports" {
#   dynamic "ingress" {
#     for_each = var.ports
#     iterator = port
#     content {
#       description = port.value["name"]
#       from_port   = port.value["port"]
#       to_port     = port.value["port"]
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   # allow traffic from everywhere
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

# }

# resource "aws_ecs_service" "backend-server" {
#   name            = "backend-server"
#   cluster         = aws_ecs_cluster.ecs.id
#   task_definition = aws_ecs_task_definition.task_definition.id
#   desired_count   = 1

#   ordered_placement_strategy {
#     type  = "binpack"
#     field = "cpu"
#   }

#   # network_configuration {
#   #   subnets          = data.aws_subnets.selected.ids
#   #   security_groups  = aws_security_group.network_ports.id
#   #   assign_public_ip = true
#   # }

#   # load_balancer {
#   #   target_group_arn = aws_lb_target_group.ecs-target-group.arn
#   #   container_name   = "backend-server"
#   #   container_port   = var.port
#   # }

# }
