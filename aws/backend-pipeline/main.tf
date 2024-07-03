module "ecr" {
  source       = "./ecr"
  project_name = var.project_name
}
module "security_group" {
  source = "./security_group"
  ports  = var.ports
}
module "target_group" {
  source       = "./target_group"
  project_name = var.project_name
}
module "ecs" {
  source       = "./ecs"
  project_name = var.project_name
  region       = var.region
  env          = var.env
  env_file_arn = var.env_file_arn
  ecs_role     = var.ecs_role
}
