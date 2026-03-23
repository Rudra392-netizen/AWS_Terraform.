terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"

    }
  }
}

#configure the AWS provider
provider "aws" {
  region = "us-east-2"
}
