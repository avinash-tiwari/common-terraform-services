variable "project_name" {
  type        = string
  description = "Name of the project"
}
variable "health_endpoint" {
  type        = string
  default     = "/health"
  description = "Health endpoint of the target group"
}
