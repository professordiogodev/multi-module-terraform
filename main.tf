terraform {
  # Change this !!! Use your own s3 bucket and DynamoDB instead!
  backend "s3" {
    bucket         = "my-diogoritto-state-bucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "diogoritto-terraform-lock"
  }

  required_providers {
    aws    = { source = "hashicorp/aws", version = "~> 6.0"    } # Provider (plugins) that talks with AWS
    tls    = { source = "hashicorp/tls", version = "~> 4.0"    } # Provider (plugins) that does SSH stuff
    random = { source = "hashicorp/random", version = "~> 3.0" } # Provider (plugins) that does "random numbers" stuff
    local  = { source = "hashicorp/local", version = "~> 2.0"  } # Provider (plugins) that creates files
  }
}

module "my-infrastructure-1" {
  source = "./modules/computer_storage"
  instance_name = "my-ec2-1"
  instance_type = "t3.micro"
  ami_id = "ami-0de6934e87badb694"
  bucket_prefix = "my-diogus-bucketus"
  key_name = "diogus-key-1"
}

module "my-infrastructure-2" {
  source = "./modules/computer_storage"
  instance_name = "my-ec2-2"
  instance_type = "t3.micro"
  ami_id = "ami-0de6934e87badb694"
  bucket_prefix = "my-diogus-bucketus"
  key_name = "diogus-key-2"
}

module "my-infrastructure-3" {
  source = "./modules/computer_storage"
  instance_name = "my-ec2-3"
  instance_type = "t3.micro"
  ami_id = "ami-0de6934e87badb694"
  bucket_prefix = "my-diogus-bucketus"
  key_name = "diogus-key-3"
}
