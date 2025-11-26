provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_server" {
  count         = 3
  ami           = "ami-03695d52f0d883f65"
  instance_type = "t3.micro"
  tags = {
    Name = "aviz-tf-server" 
  }
}
