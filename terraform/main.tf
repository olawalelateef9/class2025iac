terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}


resource "aws_instance" "nginx-node" {
  ami                    = "ami-0eeda20e2e0c4bba1"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0786335ea9e3bbe1d"
  vpc_security_group_ids = ["sg-01ce2395a89767248"]
  key_name               = "MasterClass9"

  tags = {
    Name = "terraform-nginx-node"
  }
}