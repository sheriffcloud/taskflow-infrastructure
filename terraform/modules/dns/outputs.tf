
output "route53_nameservers" {
  description = "Nameservers to configure on Namecheap"
  value       = aws_route53_zone.main.name_servers
}

output "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  value       = aws_acm_certificate.main.arn
}

output "zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}