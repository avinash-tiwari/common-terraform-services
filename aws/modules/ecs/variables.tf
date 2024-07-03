variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "ecs_role" {
  description = "ARN of the cluster role"
  type        = string
}

variable "env" {
  description = "Role of the instance, prod, dev, etc."
  type        = string
}

variable "env_file_arn" {
  description = "ARN of the env file in use"
  type        = string
}

variable "port" {
  description = "Application port"
  type        = number
  default     = 3000
}


variable "region" {
  description = "AWS region"
  type        = string
}


variable "ecr_url" {
  description = "ECR image URL"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}
variable "security_group_id" {
  description = "Security group Id"
  type        = string
}
variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(any)
}
