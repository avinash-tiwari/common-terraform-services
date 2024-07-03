resource "aws_ecs_cluster" "ecs" {
  name = var.project_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
