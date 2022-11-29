output "private_subnets" {
  description = "List of IDs of private subnets"
  value = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value = module.vpc.public_subnets
}

output "vpc-id" {
  description = "The ID of the Default VPC"
  value = module.vpc.vpc_id
}

output "alb_dns_name" {
  value = module.ec2.alb-dns-name
}
/*
output "hosted_zone_name_servers" {
  value = module.network.name-servers
}
*/
output "cloudfront_domain_name" {
  value = module.network.cloudfront-domain-name
}

output "vpc-cidr" {
  description = "The CIDR range of the VPC"
  value = module.vpc.vpc_cidr_block
}

output "domain-name" {
  description = "The name of the domain that you route traffic for"
  value = module.network.domain-name
}

data "aws_instances" "bastion-host-public-ipv4-address" {
  filter {
    name = "instance.group-id"
    values = [module.network.bastion-sg]
  }
}
output "bastion-host-public-ipv4-address" {
  value = data.aws_instances.bastion-host-public-ipv4-address.public_ips
}

output "ssh-command" {
  value = "ssh -i /path/key-pair-name.pem instance-user-name@instance-public-dns-name"
}

output "linux-command-to-get-your-public-ip" {
  value = "dig +short myip.opendns.com @resolver1.opendns.com"
}

data "aws_instances" "private-ipv4-addresses" {
  filter {
    name = "subnet-id"
    values = module.vpc.private_subnets
  }
  filter {
    name = "vpc-id"
    values = [module.vpc.vpc_id]
  }
}
output "web-and-app-server-private-ips" {
  value = data.aws_instances.private-ipv4-addresses.private_ips
}

output "db_endpoint" {
  value = module.db.db_endpoint
}