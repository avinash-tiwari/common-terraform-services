variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "subnetIds" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "default_target_group_arn" {
  type        = string
  description = "Default target group ARN"
}
