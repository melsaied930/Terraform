terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile                  = "default"
  region                   = var.aws_ec2_availability_zone
  shared_credentials_files = ["~/.aws/credentials"]
}