# Create a VPC
resource "aws_vpc" "vpc_kaggle" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
   Name = "VPC kaggle"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.vpc_kaggle.id
  tags = {
   Name = "gateway kaggle"
  }
}

# Create a public subnet
resource "aws_subnet" "subnet_kaggle" {
  vpc_id                  = aws_vpc.vpc_kaggle.id
  cidr_block              = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

# Create a Route Table for the Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_kaggle.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public" {
   subnet_id = aws_subnet.subnet_kaggle.id
   route_table_id = aws_route_table.public.id
}

# Output the Public Subnet ID
output "public_subnet_id" {
   value = aws_subnet.subnet_kaggle.id
}

# Create security group
resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.vpc_kaggle.id

  # Inbound Rules
  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "Allow TCP"
    from_port        = 8888
    to_port          = 8888
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Outbound Rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "KaggleSecurityGroup"
  }
}


