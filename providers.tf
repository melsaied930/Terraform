terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = "us-west-1c"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}
