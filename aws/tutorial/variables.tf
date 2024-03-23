variable "ports" {
  type = list(any)
}

variable "image_name" {
  type = string
}

variable "image_owner" {
  type = number
}
variable "machine_type" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "region" {
  type = string
}
