output "security_group_alb" {
    description = "ID of web security group"
    value = aws_security_group.alb.id
}

output "security_group_web" {
    description = "ID of web security group"
    value = aws_security_group.web.id
}

output "name-servers" {
    value = aws_route53_zone.public.name_servers
}

output "cloudfront-domain-name" {
    value = aws_cloudfront_distribution.web.domain_name
}
