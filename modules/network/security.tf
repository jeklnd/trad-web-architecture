####################################
# public subnet security groups
####################################


####################################
# web tier security groups
####################################

# web tier alb sg
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
    description = "Allow outbound traffic to instances on the instance listener and health check ports."
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = aws_security_group.web.id
    security_group_id = aws_security_group.alb.id
}

# web tier servers
resource "aws_security_group" "web" {
    name = "${var.env}-web-sg"
    description = "web tier servers security group"
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

####################################
# app tier security groups
####################################

# app tier alb sg
resource "aws_security_group" "app-tier-alb" {
    name = "${var.env}-app-tier-alb-sg"
    description = "app-tier alb security group"
    vpc_id = var.vpc-id
}

resource "aws_security_group_rule" "app-tier-alb-ingress" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.vpc-cidr]
    security_group_id = aws_security_group.app-tier-alb.id
    description = "allow  inbound traffic from the VPC CIDR on the load balancer listener port"
}

resource "aws_security_group_rule" "app-tier-alb-egress" {
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = aws_security_group.app-tier-servers.id
    security_group_id = aws_security_group.app-tier-alb.id
    description = "allow outbound traffic to the instances on the instance listener and health check ports"
}

# app tier servers
resource "aws_security_group" "app-tier-servers" {
    name = "${var.env}-app-tier-servers-sg"
    description = "app tier servers security group"
    vpc_id = var.vpc-id
}

resource "aws_security_group_rule" "http-ingress-from-app-tier-alb" {
    type = "ingress"
    from_port = 80
    to_port = 80
    source_security_group_id = aws_security_group.app-tier-alb.id
    protocol = "tcp"
    security_group_id = aws_security_group.app-tier-servers.id
}

resource "aws_security_group_rule" "https-ingress-from-app-tier-alb" {
    type = "ingress"
    from_port = 443
    to_port = 443
    source_security_group_id = aws_security_group.app-tier-alb.id
    protocol = "tcp"
    security_group_id = aws_security_group.app-tier-servers.id
}

resource "aws_security_group_rule" "egress-from-app-tier-servers" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.app-tier-servers.id
}