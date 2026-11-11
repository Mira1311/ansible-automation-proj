terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
    region = "ap-southeast-1"
}

#Find newest Ubuntu version from Canonical
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Official ID of Canonical

  filter {
    name = "name"
    #Use "*" to get newest version
    values = ["*ubuntu*26.04-amd64-server-*"]
  }
}
#Create SG
resource "aws_security_group" "my_project_security" {
  name = "my-project-security-group"
  description = "Created SG use for my project!"

  #No inbound

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Give public key into AWS
resource "aws_key_pair" "deploy_key" {
  key_name = "my-FPj-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
#Create EC2 instances
resource "aws_instance" "finops-target" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

#Attach Role
  iam_instance_profile = "IAMDocker"
#Attach security_group
  vpc_security_group_ids = [aws_security_group.my_project_security.id]
#Attach the key into the instances
  key_name = aws_key_pair.deploy_key.key_name
  tags = {
    Name = "FinOps-Node-Target-TF"
    Project = "MyFPj-DevOps"
  }
} 
