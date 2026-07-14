resource "aws_route53_record" "cert_validation" {
  name    = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_value]
  zone_id = aws_route53_zone.main.zone_id
  ttl     = 60
}