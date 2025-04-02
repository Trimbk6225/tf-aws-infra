data "aws_caller_identity" "current" {}

data "aws_route53_zone" "domain_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "a_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.web_app_alb.dns_name
    zone_id                = aws_lb.web_app_alb.zone_id
    evaluate_target_health = true
  }
}

