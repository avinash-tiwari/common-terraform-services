variable "username" {
  default = "Aviansh"
  type    = string
}

variable "age" {
  default = 26
  type    = number
}

variable "users" {
  type    = list(string)
  default = ["avinash", "anirudh", "anurag"]
}

variable "index" {
  type    = number
  default = 0
}

variable "userAge" {
  type = map(any)
  default = {
    avinash   = 26
    pratiksha = 25
  }
}

# passing variables non-interactively
# terraform plan -var username="Avinash tiwari" -var "age=23"

# to use variables from environment, start exporting the variables like this
# export TF_VAR_username="Tiwari"
