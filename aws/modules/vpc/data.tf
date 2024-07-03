# data "aws_vpc" "default" {
#   default = true
# }

# locals {
#   selected_vpc = var.create_new ? aws_vpc.new_vpc[0] : data.aws_vpc.default
# }

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.create_new ? aws_vpc.new_vpc[0].id : data.aws_vpc.default.id]
  }
}

locals {
  subnet_map = { for idx, subnet_id in data.aws_subnets.subnets.ids : idx => "${subnet_id}" }
}

data "aws_subnet" "subnet" {
  for_each = local.subnet_map
  id       = each.value
}
