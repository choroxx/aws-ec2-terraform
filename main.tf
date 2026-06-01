terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0f2bbfa3fa9f61ba9"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-demo"
  }
}