output "lb_url" {
  value       = aws_lb.lb.dns_name
  description = "DNS of the load balancer"
}
