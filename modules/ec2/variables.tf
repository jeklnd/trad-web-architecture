variable "subnets" {
    default = []
}

variable "web-alb-sg" {
    default = []
}

variable "vpc-id" {
    default = ""
}

variable "key-name" {
    default = ""
}

variable "web-tier-vpc-zone-identifier" {
    default = []
}

variable "web-tier-target-group-arns" {
    default = []
}

variable "instance-type" {
    default = "t2.micro"
}

variable "web-servers-sg" {
    default = ""
}

variable "app-tier-alb-sg" {
    default = ""
}

variable "private-app-subnets" {
    default = ""
}

variable "app-tier-vpc-zone-identifier" {
    default = []
}

variable "app-tier-target-group-arns" {
    default = []
}

variable "image-id" {
    default = ""
}

variable "app-tier-servers-sg" {
    default = ""
}
