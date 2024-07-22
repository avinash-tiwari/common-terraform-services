resource "mongodbatlas_project" "mongodb-aws-terraform-rnd" {
  name   = var.project_name
  org_id = var.org_id
}

resource "mongodbatlas_cluster" "cluster-mongodb-aws-terraform-rnd" {
  project_id                  = mongodbatlas_project.mongodb-aws-terraform-rnd.id
  name                        = var.cluster_name
  cluster_type                = "REPLICASET"
  provider_name               = "AWS"
  provider_region_name        = var.mongodb_atlas_region
  provider_instance_size_name = "M10"
}

# resource "mongodbatlas_network_container" "container-mongodb-aws-terraform-rnd" {
#   project_id       = mongodbatlas_project.mongodb-aws-terraform-rnd.id
#   atlas_cidr_block = var.aws_vpc_cidr_block
#   provider_name    = "AWS"
#   region_name      = var.mongodb_atlas_region
# }

# Ref: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/network_peering#example-usage---peering-connection-only-container-exists 
resource "mongodbatlas_network_peering" "peering-mongodb-aws-terraform-rnd" {
  project_id = mongodbatlas_project.mongodb-aws-terraform-rnd.id
  # [ERROR] container_id  = mongodbatlas_network_container.container-mongodb-aws-terraform-rnd.container_id
  container_id           = mongodbatlas_cluster.cluster-mongodb-aws-terraform-rnd.container_id
  vpc_id                 = aws_vpc.vpc-mongodb-aws-terraform-rnd.id
  provider_name          = "AWS"
  accepter_region_name   = var.mongodb_atlas_region
  aws_account_id         = var.aws_account_id
  route_table_cidr_block = var.aws_vpc_cidr_block
}

# Ref: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project_ip_access_list
resource "mongodbatlas_project_ip_access_list" "ip_whitelist" {
  project_id = mongodbatlas_project.mongodb-aws-terraform-rnd.id
  # [ERROR] cidr_block = aws_security_group.sg-mongodb-aws-terraform-rnd.ingress[0].cidr_blocks[0]
  # [ERROR] cidr_block = aws_security_group.sg-mongodb-aws-terraform-rnd.vpc_id # Using the VPC ID for simplicity
  # cidr_block = "0.0.0.0/0"
  # ip_address = "223.190.83.70" # Current/static IP address to allow
  aws_security_group = aws_security_group.sg-mongodb-aws-terraform-rnd.id
  depends_on         = [mongodbatlas_network_peering.peering-mongodb-aws-terraform-rnd]
}
