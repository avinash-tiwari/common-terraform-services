# resource "aws_default_vpc" "default" {
#   count = var.create_new ? 0 : 1
#   tags = {
#     Name = "Default VPC"
#   }
# }

resource "aws_vpc" "new_vpc" {
  count      = var.create_new ? 1 : 0
  cidr_block = "10.0.0.0/16"
}

data "aws_vpc" "default" {
  default = true
}

locals {
  selected_vpc = var.create_new ? aws_vpc.new_vpc[0] : data.aws_vpc.default
}
