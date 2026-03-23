#How to store terraform.tfstate file on remote backend (s3 bucket) using terraform

terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "rudra-tf-backend-98188"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }

}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Create S3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "rudra-tf-bucket-2026-98188"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

