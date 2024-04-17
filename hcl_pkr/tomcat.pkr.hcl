packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_aws_account_id" {
  type    = string
  default = "724541603350"
}

variable "application_name" {
  type    = string
  default = "cloudbinary"
}

variable "application_version" {
  type    = string
  default = "1.0.0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "packer_profile" {
  type    = string
  default = "packer-ec2-s3"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "source_ami" {
  type    = string
  default = "ami-007020fd9c84e18c7"
}

source "amazon-ebs" "ubuntu" {
  ami_name                    = "tom"
  associate_public_ip_address = "true"
  force_delete_snapshot       = "true"
  force_deregister            = "true"

  instance_type = "t2.micro"
  profile       = "default"
  region        = "ap-south-1"
  source_ami    = "ami-007020fd9c84e18c7"
  ssh_username  = "ubuntu"
  tags = {
    CreatedBy = "Packer"
    Name      = "tom"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = ["echo `date` `hostname`",
      "sudo apt-get update"
    ]
  }
  provisioner "shell" {
    inline = ["sudo apt-get update",
      "sudo apt-get install software-properties-common -y"
    ]
  }

  provisioner "shell" {
    inline = ["sudo add-apt-repository --yes --update ppa:ansible/ansible", "sudo apt-get install ansible -y"
    ]
  }
  provisioner "shell" {
    inline = ["sudo apt-get install git -y",
      " sudo apt-get install curl -y",
      " sudo apt-get install wget -y"
    ]
  }
  provisioner "shell" {
    inline = [
    "sudo apt-get update", "sudo apt-get install zip -y"]
  }
  #  provisioner "shell" {
  #    inline = [
  #      "sudo snap install amazon-ssm-agent --classic",
  #      "sudo snap list amazon-ssm-agent",
  #    "sudo snap start amazon-ssm-agent"]
  #  }
}