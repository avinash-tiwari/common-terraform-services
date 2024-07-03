module "ecr" {
  source       = "./ecr"
  project_name = var.project_name
}

output "ecr_repo_url" {
  value = "ECR repo URL to push code = ${modules.ecr.ecr_repo_url}"
}
