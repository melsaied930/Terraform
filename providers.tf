terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile                  = "default"
  region                   = "us-west-2"
  shared_credentials_files = ["~/.aws/credentials"]
}
