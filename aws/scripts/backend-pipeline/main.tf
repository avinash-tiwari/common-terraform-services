module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
}
module "security_group" {
  source = "../../modules/security_group"
  ports  = var.ports
  vpc_id = var.vpc_id
}
module "target_group" {
  depends_on   = [module.security_group]
  source       = "../../modules/target_group"
  project_name = var.project_name
  vpc_id       = var.vpc_id
}
module "ecs" {
  depends_on        = [module.target_group]
  source            = "../../modules/ecs"
  project_name      = var.project_name
  region            = var.region
  env               = var.env
  env_file_arn      = var.env_file_arn
  ecs_role          = var.ecs_role
  ecr_url           = module.ecr.url
  security_group_id = module.security_group.id
  subnet_ids        = var.subnet_ids
  target_group_arn  = module.target_group.arn
}
