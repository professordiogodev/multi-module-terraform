
# ======== PROVIDERS ==========

# 1. Provider Configuration
provider "aws" {
  region = "eu-central-1"
}

# ======== SSH KEY ==========

# 2. Resource: RSA Private Key
resource "tls_private_key" "example_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 3. Resource: AWS Key Pair (Uploads public key to AWS)
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example_ssh_key.public_key_openssh
}

# ======== S3 BUCKET ==========

# 4. Resource: Random ID for unique S3 naming
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# 5. Resource: S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.bucket_prefix}-${random_id.bucket_suffix.hex}"
}

# ======== SECURITY GROUP ==========

# 6. Resource: Security Group allowing SSH
resource "aws_security_group" "ssh_access" {
  name        = "${var.instance_name}-allow-ssh"
  description = "Allow inbound SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ======== EC2 INSTANCE ==========

# 7. Resource: EC2 Instance
resource "aws_instance" "my_server" {
  ami                         = var.ami_id # Amazon Linux 2023 (Verify for your region)
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}

# ======== CREATE LOCAL FILE (for key) ==========
resource "local_file" "ssh_key_file" {
  content         = tls_private_key.example_ssh_key.private_key_pem
  filename        = "${path.module}/../../keys/${var.instance_name}-key.pem"
  file_permission = "0400" # Sets read-only permissions for the owner
}
