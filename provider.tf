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

module "my_ec2_instance" {
  source = "./modules"

  ec2_instance_type = var.ec2_instance_type
  ec2_instance_name = var.ec2_instance_name
  ec2_ami_id        = data.aws_ami.my_ami.id
}
output "instance_id" {
  value = module.my_ec2_instance.ec2_instance_id
}