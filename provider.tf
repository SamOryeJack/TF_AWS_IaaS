provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "my_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.my_ami.id
  instance_type = var.ec2_instance_type

  tags = {
    Name = var.ec2_instance_name
  }
}