provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "description"
    values = ["Amazon Linux 2023*"]
  }
}

variable "insatnce_type" {
    type = string
    default = "t3.small"
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.al2023.id
  instance_type = var.insatnce_type

  tags = {
    Name = "HCP-TF-LOCK-Test"
  }
}

output "ami_used" {
  value = data.aws_ami.al2023.id
}
