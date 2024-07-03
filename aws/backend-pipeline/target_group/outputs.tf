output "arn" {
  value       = aws_lb_target_group.ecs-target-group.arn
  description = "ARN of the target group"
}
