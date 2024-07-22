# AWS
variable "aws_region" {
  description = "The AWS region"
}
variable "aws_access_key" {
  description = "The AWS access key"
}
variable "aws_account_id" {
  description = "The AWS account id"
}
variable "aws_secret_key" {
  description = "The AWS secret key"
}
variable "aws_vpc_cidr_block" {
  description = "The AWS VPC CIDR"
}

# MongoDB Atlas
variable "project_name" {
  description = "Name of the project"
}
variable "org_id" {
  description = "The organisation id"
}
variable "cluster_name" {
  description = "Name of the cluster"
}
variable "mongodb_atlas_region" {
  description = "The MongoDB Atlas region"
}
variable "mongodb_atlas_public_key" {
  description = "The public key for MongoDB Atlas"
}
variable "mongodb_atlas_private_key" {
  description = "The private key for MongoDB Atlas"
}
