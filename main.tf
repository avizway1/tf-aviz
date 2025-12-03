provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_server" {
  ami           = "ami-03695d52f0d883f65"
  instance_type = "t3.micro"
  tags = {
    Name = "aviz-tf-test"
  }
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "aviz-hcp-test-121211"
  tags = {
    Environment = "PublicAccessDemo"
  }
}
