output "id" {
  value       = var.create_new ? aws_vpc.new_vpc[0].id : data.aws_vpc.default.id
  description = "id of the vpc used throughout the project"
}

output "subnet_ids" {
  value       = data.aws_subnet.subnet
  description = "subnet Ids"
}
