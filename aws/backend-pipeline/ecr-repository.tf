resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

output "ecr_repo_url" {
  value = "ECR repo URL to push code = ${aws_ecr_repository.ecr_repo.repository_url}"
}
