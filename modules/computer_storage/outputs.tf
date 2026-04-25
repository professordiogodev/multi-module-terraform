
# ======== OUTPUTS ==========

# Output: Private Key (Sensitive)
output "private_key" {
  value     = tls_private_key.example_ssh_key.private_key_pem
  sensitive = true
}

# Output: S3 Bucket Name
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}

# Output: EC2 Public IP
output "instance_public_ip" {
  value = aws_instance.my_server.public_ip
}
