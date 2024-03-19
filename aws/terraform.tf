terraform {
  required_version = "1.7.4"

  # remote backend file, to store the remote file in remote location
  # backend "s3" {
  #   bucket         = "test-tf-states-1"
  #   region         = "us-east-2"
  #   key            = "terraform.tfstate"
  #   dynamodb_table = "table-name" # table to avoid race-around condition
  # }
}
