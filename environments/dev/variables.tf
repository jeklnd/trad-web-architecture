/*
variable "AWS_ACCESS_KEY" {
  default = ""
}

variable "AWS_SECRET_KEY" {
  default = ""
}
*/

variable "AWS_REGION" {
  default     = "us-east-1"
  description = "US East (N. Virginia) Region"
}

variable "env" {
  default = "dev"
  description = "The environment being worked in"
}

variable "key_name" {
  description = "The key name that should be used for the instance."
}

variable "my_ip" {
    type = string
    description = "The IP address from which to access the bastion host"
    sensitive = true
}