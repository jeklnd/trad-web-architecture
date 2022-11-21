/*
resource "aws_launch_configuration" "web" {
    name_prefix = "web servers"
    image_id = "ami-0b0dcb5067f052a63" # Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2
    instance_type = "t2.micro"
    key_name = var.key_name
    security_groups = [module.network.security_group_web]

    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_autoscaling_group" "web" {
    name = "web-asg"
    min_size = 2
    max_size = 6
    vpc_zone_identifier = [module.vpc.private_subnets[0], module.vpc.private_subnets[3]]
}
*/