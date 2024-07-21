locals {
  iam_role_arn = var.ecs_role != "" ? var.ecs_role : aws_iam_role.cluster_role[0].arn
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.project_name}-${var.env}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = local.iam_role_arn
  task_role_arn            = local.iam_role_arn
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name : "backend-server"
      image     = var.ecr_url
      cpu       = 1024
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
        }
      ]
      environmentFiles = [
        {
          value = "${var.env_file_arn}"
          type  = "s3"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-region"        = var.region
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-stream-prefix" = "ecs/backend-server"
        }

      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}
