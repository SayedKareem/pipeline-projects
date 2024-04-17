# Versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Providers
provider "aws" {
  region = "ap-south-1"
  #profile = "default"
}

data "aws_ami" "tom" {
  most_recent = true
  owners      = ["724541603350"]

  filter {
    name   = "name"
    values = ["tom*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hmv"]
  }

}


# Resource -aws -ec2 -ubuntu
resource "aws_instance" "app" {
  ami                    = "data.aws_ami.tom.id"
  instance_type          = "t2.micro"
  key_name               = "mumbai_keys"
  subnet_id              = "subnet-07e81f1c707f0f27c"
  vpc_security_group_ids = ["sg-09733848669e9bff4"]
  iam_instance_profile   = "SSM_Instanceprofile"

  tags = {
    Name        = "app instance-1"
    Environment = "app"
    ProjectName = "Cloud Binary"
    ProjectID   = "2024"
    CreatedBy   = "IAC Terraform"
  }

}

