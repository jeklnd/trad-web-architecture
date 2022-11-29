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

variable "vpc-zone-identifier" {
    default = []
}

variable "target-group-arns" {
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