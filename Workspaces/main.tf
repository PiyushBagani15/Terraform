provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "os1" { #creating os1 instance
  ami = "ami-010aff33ed5991201"
  instance_type = lookup(var.instance-type, terraform.workspace, "Env Not Found") #terraform.workspace - This is inbuilt keyword for workspace
  security_groups = ["default"]
  key_name = "key1515"
  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "aws-1"
  }
}


output "out-1" {
  value = terraform.workspace
}

    

