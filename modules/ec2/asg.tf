resource "aws_autoscaling_group" "web" {
    name = "web-servers"
    min_size = 2
    desired_capacity = 2
    max_size = 6
    vpc_zone_identifier = var.vpc-zone-identifier
    launch_configuration = aws_launch_configuration.web.name
    health_check_type = "ELB"
    target_group_arns = [var.target-group-arns]
    wait_for_capacity_timeout = "10m"
}

resource "aws_launch_configuration" "web" {
    name_prefix = "web-servers-"
    image_id = "ami-0b0dcb5067f052a63" # Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2
    instance_type = var.instance-type
    key_name = var.key-name
    security_groups = var.web-servers-sg
    user_data = <<-EOF
#!/bin/sudo bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd
systemctl enable httpd
chown ec2-user:ec2-user -Rf /var/www 

echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF
#<p>DB address: ${db_address}</p>
#<p>DB port: ${db_port}</p>

    
    lifecycle {
        create_before_destroy = true
    }
}
