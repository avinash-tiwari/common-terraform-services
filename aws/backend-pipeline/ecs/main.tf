resource "aws_ecs_service" "backend-server" {
  name            = "backend-server"
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.task_definition.id
  desired_count   = 1

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  # network_configuration {
  #   subnets          = data.aws_subnets.selected.ids
  #   security_groups  = aws_security_group.network_ports.id
  #   assign_public_ip = true
  # }

  # load_balancer {
  #   target_group_arn = aws_lb_target_group.ecs-target-group.arn
  #   container_name   = "backend-server"
  #   container_port   = var.port
  # }

}
