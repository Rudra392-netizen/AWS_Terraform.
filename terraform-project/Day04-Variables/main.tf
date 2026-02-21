resource "aws_s3_bucket" "example" {
  bucket = "rudra-tf-1234"

  tags = {
    Name        = "My bucket"
    Environment = "${var.Environment}"
  }
}


# Create EC2 Instance

resource "aws_instance" "simple_ec2" {
  ami           = "ami-084a0102434a2b8ce" # Ubuntu Linux LTS (Mumbai region)
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "rudra-simple-ec2"
  }
}
