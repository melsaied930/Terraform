terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile                  = "default"
  region                   = module.vpc.region
  shared_credentials_files = ["~/.aws/credentials"]
}