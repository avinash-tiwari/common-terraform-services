output "security_group_id" {
  value = "Security group = ${module.security_group.id}"
}

output "target_group_arn" {
  value = "Target group = ${module.target_group.arn}"
}

output "application_dns" {
  value = "App URL = ${module.aws_lb.lb_url}"
}
