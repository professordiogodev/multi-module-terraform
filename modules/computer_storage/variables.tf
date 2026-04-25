variable "instance_name" {
  type    = string
  default = "Terraform-Instance"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  type = string
}

variable "bucket_prefix" {
  type    = string
  default = "my-unique-diogo-bucket"
}

variable "key_name" {
  type    = string
  default = "my-terraform-key"
}
