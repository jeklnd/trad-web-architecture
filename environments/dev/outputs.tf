output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "vpc_id" {
  description = "The ID of the Default VPC"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  value = module.ec2.alb-dns-name
}