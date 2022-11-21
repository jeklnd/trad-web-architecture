module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env}-custom-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnet_names = ["private-web-1", "private-app-1", "private-db-1", "private-web-2", "private-app-2", "private-db-2"]
  public_subnet_names = ["public-1", "public-2"]

  # Create one NAT Gateway per AZ
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "network" {
  source = "../../modules/network"

  #security.tf arguments
  vpc-id = module.vpc.vpc_id
  env = var.env
}

module "ec2" {
  source = "../../modules/ec2"

  # alb.tf arguments
  web-alb-sg = [module.network.security_group_alb]
  subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  vpc-id = module.vpc.vpc_id

  # asg.tf arguments
  key-name = "jesse@jdkpc"
  vpc-zone-identifier = [module.vpc.private_subnets[0], module.vpc.private_subnets[3]]
  target-group-arns = module.ec2.target-group-arns
  instance-type = "t2.micro"
  web-servers-sg = [module.network.security_group_web]
}