# Generate a new SSH private key
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "example" {
  key_name   = "example-key-pair"
  public_key = tls_private_key.example.public_key_openssh
}
