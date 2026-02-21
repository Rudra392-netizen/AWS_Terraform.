terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

#How to create s3 bucket using terraform
resource "aws_s3_bucket" "first_bucket" {
  bucket = "rudra-tf-bucket-2026-98188"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
