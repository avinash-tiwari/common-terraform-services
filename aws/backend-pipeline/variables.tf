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

variable "ports" {
  type = list(any)
}
