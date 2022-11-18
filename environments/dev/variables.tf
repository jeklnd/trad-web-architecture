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
