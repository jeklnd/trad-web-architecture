################################################################################
# Web security group
################################################################################

resource "aws_security_group" "web" {
    name = "${var.env}-web-sg"
    description = "web server security group"
    vpc_id = var.vpc-id
}

resource "aws_security_group_rule" "inbound_http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    source_security_group_id = aws_security_group.alb.id
    protocol = "tcp"
    security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "inbound_https" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = aws_security_group.alb.id
    security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "outbound_all" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web.id
}

################################################################################
# ALB security group
################################################################################
resource "aws_security_group" "alb" {
    name = "${var.env}-alb-sg"
    description = "alb security group"
    vpc_id = var.vpc-id
}

resource "aws_security_group_rule" "inbound_all" {
    description = "Allow inbound traffic on the load balancer listener port."
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "web-listener-and-health-check" {
    description = "Allow outbound traffic to instances on the instance listener and health check port."
    type = "egress"
    from_port = 80
    to_port = 80
    source_security_group_id = aws_security_group.web.id
    protocol = "tcp"
    security_group_id = aws_security_group.alb.id
}