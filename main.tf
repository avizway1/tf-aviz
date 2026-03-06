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
    Name = "HCP-TF-LOCK-Test-Sentinal-test"
  }
}

output "ami_used" {
  value = data.aws_ami.al2023.id
}


resource "aws_s3_bucket" "public_bucket" {
  bucket = "aviz-hcp-test-awar07"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "this" {
  bucket     = aws_s3_bucket.public_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.this]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
    }]
  })
}
