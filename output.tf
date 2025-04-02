output "route53_domain_record" {
  description = "DNS record for the domain"
  value       = aws_route53_record.a_record.name
}

# output "route53_zone_id" {
#   description = "Route53 hosted zone ID"
#   value       = aws_route53_zone.domain_zone.zone_id
# }
