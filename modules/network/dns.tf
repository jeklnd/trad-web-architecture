resource "aws_acm_certificate" "cert" {
    domain_name = "jdkresume.com"
    subject_alternative_names = ["www.jdkresume.com"]
    validation_method = "DNS"

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "this" {
    certificate_arn = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]

    timeouts {
        create = "5m"
    }
}  

resource "aws_route53_record" "this" { 
    zone_id = data.aws_route53_zone.root.zone_id
    
    for_each = { 
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
            name = dvo.resource_record_name
            record = dvo.resource_record_value
            type = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name = each.value.name
    type = each.value.type
    records = [each.value.record]
    ttl = 60
}

# Note – The hosted zone must already exist and the delegation set must match the name servers associated with the registered domain.
data "aws_route53_zone" "root" {
    name = "jdkresume.com"
}

resource "aws_route53_record" "root" {
    allow_overwrite = true
    zone_id = data.aws_route53_zone.root.zone_id
    name = "jdkresume.com"
    type = "A"
    
    alias {
        name = aws_cloudfront_distribution.web.domain_name
        zone_id = "Z2FDTNDATAQYW2" # For CloudFront distributions, the value is always Z2FDTNDATAQYW2
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "www" {
    allow_overwrite = true
    zone_id = data.aws_route53_zone.root.zone_id
    name = "www.jdkresume.com"
    type = "A"
    
    alias {
        name = aws_cloudfront_distribution.web.domain_name
        zone_id = "Z2FDTNDATAQYW2" # For CloudFront distributions, the value is always Z2FDTNDATAQYW2
        evaluate_target_health = true
    }
}