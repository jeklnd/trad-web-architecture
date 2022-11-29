####################################
# bastion host asg
####################################
resource "aws_autoscaling_group" "bastion" {
    name = "bastion-hosts"
    min_size = 1
    desired_capacity = 1
    max_size = 2
    vpc_zone_identifier = var.bastion-vpc-zone-identifier
    launch_configuration = aws_launch_configuration.bastion.name
    health_check_type = "EC2"
    wait_for_capacity_timeout = "10m"
}

resource "aws_launch_configuration" "bastion" {
    name_prefix = "bastion-hosts-"
    image_id = var.image-id
    instance_type = var.instance-type
    key_name = var.key_name
    security_groups = var.bastion-sg
    user_data = <<-EOF
#!/bin/sudo bash
yum update -y
EOF
    
    lifecycle {
        create_before_destroy = true
    }
}

####################################
# web tier asg
####################################

resource "aws_autoscaling_group" "web" {
    name = "web-tier-servers"
    min_size = 2
    desired_capacity = 2
    max_size = 6
    vpc_zone_identifier = var.web-tier-vpc-zone-identifier
    launch_configuration = aws_launch_configuration.web.name
    health_check_type = "ELB"
    target_group_arns = [var.web-tier-target-group-arns]
    wait_for_capacity_timeout = "10m"
}

resource "aws_launch_configuration" "web" {
    name_prefix = "web-servers-"
    image_id = var.image-id
    instance_type = var.instance-type
    key_name = var.key_name
    security_groups = var.web-tier-servers-sg
    user_data = <<-EOF
#!/bin/sudo bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd
systemctl enable httpd
chown ec2-user:ec2-user -Rf /var/www 

echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF

    
    lifecycle {
        create_before_destroy = true
    }
}

####################################
# app tier asg
####################################
resource "aws_autoscaling_group" "app-tier" {
    name = "app-tier-servers"
    min_size = 2
    desired_capacity = 2
    max_size = 6
    vpc_zone_identifier = var.app-tier-vpc-zone-identifier
    launch_configuration = aws_launch_configuration.app.name
    health_check_type = "ELB"
    target_group_arns = [var.app-tier-target-group-arns]
    wait_for_capacity_timeout = "10m"
}

resource "aws_launch_configuration" "app" {
    name_prefix = "app-servers-"
    image_id = var.image-id
    instance_type = var.instance-type
    key_name = var.key_name
    security_groups = var.app-tier-servers-sg
    user_data = <<-EOF
#!/bin/sudo bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd
systemctl enable httpd
chown ec2-user:ec2-user -Rf /var/www 

echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF
    
    lifecycle {
        create_before_destroy = true
    }
}