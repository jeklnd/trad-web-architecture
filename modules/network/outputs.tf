output "security_group_web" {
    description = "ID of web security group"
    value = aws_security_group.web.id
}

output "security_group_alb" {
    description = "ID of web security group"
    value = aws_security_group.alb.id
}