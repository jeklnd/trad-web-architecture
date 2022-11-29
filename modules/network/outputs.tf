output "security_group_alb" {
    description = "ID of web security group"
    value = aws_security_group.alb.id
}

output "web-tier-servers-sg" {
    description = "ID of web-tier servers' security group"
    value = aws_security_group.web.id
}

output "name-servers" {
    value = data.aws_route53_zone.root.name_servers
}

output "cloudfront-domain-name" {
    value = aws_cloudfront_distribution.web.domain_name
}

output "app-tier-alb-sg" {
    description = "ID of app tier alb security group"
    value = aws_security_group.app-tier-alb.id
}

output "app-tier-servers-sg" {
    description = "ID of app-tier servers' security group"
    value = aws_security_group.app-tier-servers.id
}

output "bastion-sg" {
    description = "ID of bastion hosts' security group"
    value = aws_security_group.public.id
}