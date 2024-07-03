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
