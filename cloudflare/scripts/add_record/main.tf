module "dns_record" {
  source       = "../../modules/records"
  record_name  = var.record_name
  record_value = var.record_value
  ttl          = var.ttl
  comment      = var.comment
}
