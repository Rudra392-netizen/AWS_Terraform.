terraform {
  backend "s3" {
    bucket       = "rudra-tf-backend-1234"
    key          = "dev/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}
