
variable "ports" {
  description = "Security group ports"
  type        = list(any)
}
variable "vpc_id" {
  description = "VPC Id"
  type        = string
}
