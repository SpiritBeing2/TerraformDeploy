variable "ami" {
  type        = string
  description = "Ubuntu AMI ID"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "name_tag" {
  type        = string
  description = "Name of the EC2 instance"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "bucket_name" {
  type        = string
  description = "Bucket containing training data"
  sensitive = true
}

variable "parameter_name" {
  type 	      = string
  description = "Parameters store containing bucket name"
}

output "public_ip" {
  value       = aws_instance.my_vm.public_ip
  description = "Public IP Address of EC2 instance"
}

output "instance_id" {
  value       = aws_instance.my_vm.id
  description = "Instance ID"
}
