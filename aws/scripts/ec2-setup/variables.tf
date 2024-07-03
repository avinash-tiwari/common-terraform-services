variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}


variable "machine_type" {
  type = string
}

variable "machine_name" {
  type = string
}

variable "author" {
  type = string
}

variable "tag-description" {
  type = string
}

variable "ports" {
  type = list(any)
}
