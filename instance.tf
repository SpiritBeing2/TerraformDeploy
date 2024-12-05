provider "aws" {
  region = var.region
}

variable "user_data_script" {
  type = string
  description = "Startup script to deploy juptyer"
  default = <<-EOF
            #!/bin/bash
            mkdir ~/.jupyter
            echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
            EOF
}

resource "aws_instance" "my_vm" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet_kaggle.id
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.example.id]
  user_data  = var.user_data_script
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  tags = {
    Name = var.name_tag
  }
}

output "ec2_user_data" {
  value = var.user_data_script
  description = "User data output"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}
