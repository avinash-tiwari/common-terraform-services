module "s3" {
  source             = "../../modules/s3"
  author             = var.author
  bucket_description = var.bucket_description
  bucket_name        = var.bucket_name
}
