variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "author" {
  type = string
}

variable "project_description" {
  type = string
}

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "env_file_arn" {
  type = string
}

variable "ecs_role" {
  type    = string
  default = ""
}

variable "port" {
  type    = number
  default = 3000
}

variable "ecr_url" {
  type        = string
  description = "ECR URL for ECS"
}



variable "ports" {
  type = list(any)
}
variable "vpc_id" {
  type        = string
  description = "VPC Id for the project"
}
variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}
