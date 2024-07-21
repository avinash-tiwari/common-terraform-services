resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.project_name}-log-group"
}

# awslogs-create-group
