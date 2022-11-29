####################################
# web tier alb
####################################

resource "aws_lb" "web-tier" {
    name = "web-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = var.web-alb-sg
    subnets = var.subnets
}

resource "aws_lb_listener" "web-tier" {
    port = 80
    protocol = "HTTP"
    load_balancer_arn = aws_lb.web-tier.arn

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.web-tier.arn
    }
}

resource "aws_lb_target_group" "web-tier" {
    name_prefix = "web-"
    target_type = "instance"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id

    health_check {
        enabled = true
        healthy_threshold = 2
        interval = 15
        matcher = "200-299"
        path = "/"
        port = 80
        protocol = "HTTP"
        timeout = "14"
        unhealthy_threshold = 3
    }
}

####################################
# app tier alb
####################################

resource aws_lb "app-tier" {
    name = "app-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = var.app-tier-alb-sg
}