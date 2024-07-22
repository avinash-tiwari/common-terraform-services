output "domain_name" {
  value = "Bucket domain name = ${aws_s3_bucket.storage.bucket_domain_name}"
}

output "arn" {
  value = "Bucket ARN = ${aws_s3_bucket.storage.arn}"
}
