# every provider has list of data sources to list down its resoruces
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.image_owner] // get it from AWS
  filter {
    name   = "name"
    values = [var.image_name]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws_ami" {
  value = data.aws_ami.ubuntu.id
}
