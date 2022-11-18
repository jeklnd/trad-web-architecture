terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
/*
  backend = "" {
    # S3 Backend documentation: https://developer.hashicorp.com/terraform/language/settings/backends/s3
  }
*/
}

provider "aws" {
  region = var.AWS_REGION
  #access_key = var.AWS_ACCESS_KEY
  #secret_key = var.AWS_SECRET_KEY
}
