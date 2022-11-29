output "web-tier-target-group-arns" {
    value = aws_lb_target_group.web-tier.arn
}

output "alb-dns-name" {
    value = aws_lb.web-tier.dns_name
}

output "app-tier-target-group-arns" {
    value = aws_lb_target_group.app-tier.arn
}