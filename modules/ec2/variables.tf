# alb.tf variables

variable "vpc-id" {
    default = ""
}

variable "web-tier-alb-sg" {
    default = []
}

variable "web-tier-alb-subnets" {
    default = []
}

variable "app-tier-alb-sg" {
    default = ""
}

variable "app-tier-alb-subnets" {
    default = ""
}

# asg.tf variables

variable "image-id" {
    default = ""
}

variable "instance-type" {
    default = "t2.micro"
}

variable "key_name" {
    default = ""
}

variable "web-tier-vpc-zone-identifier" {
    default = []
}

variable "web-tier-target-group-arns" {
    default = ""
}

variable "web-tier-servers-sg" {
    default = []
}

variable "app-tier-vpc-zone-identifier" {
    default = []
}

variable "app-tier-target-group-arns" {
    default = ""
}

variable "app-tier-servers-sg" {
    default = []
}

variable "bastion-vpc-zone-identifier" {
    default = []
}

variable "bastion-sg" {
    default = []
}

