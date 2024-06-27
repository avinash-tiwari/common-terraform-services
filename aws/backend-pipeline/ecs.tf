resource "aws_ecs_cluster" "ecs" {
  name = var.project_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.project_name}-${var.env}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name : "node-server"
      image     = "${aws_ecr_repository.ecr_repo.repository_url}"
      cpu       = 1024
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      #   environmentFiles = ["${var.env_file_arn}"]
      environmentFiles = [
        {
          value = "${var.env_file_arn}"
          type  = "s3"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
      }
    }
  ])

  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}
