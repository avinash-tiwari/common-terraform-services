output "ecr_repo_url" {
  value = "ECR repo URL = ${module.ecr.url}"
}

output "security_group_id" {
  value = "Security group = ${module.security_group.id}"
}

output "target_group_arn" {
  value = "Target group = ${module.target_group.arn}"
}
