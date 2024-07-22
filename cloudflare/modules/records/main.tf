resource "cloudflare_record" "record" {
  #   zone_id = var.cloudflare_zone_id
  name    = var.record_name
  value   = var.record_value
  type    = var.type
  ttl     = var.ttl
  comment = var.comment
}
