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
  default = "jesse@jdkpc"
  description = "(Optional) The key name that should be used for the instance."
}