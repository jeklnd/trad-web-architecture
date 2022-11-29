variable "vpc-id" {
    default = ""
}

variable "env" {
    default = ""
}

variable "alb-dns-name" {
    default = ""
}

variable "vpc-cidr" {
    default = ""
}

variable "my_ip" {
    type = string
    description = "The IP address from which to access the bastion host"
    sensitive = true
}