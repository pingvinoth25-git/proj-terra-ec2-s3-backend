terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "aws-vinoth93-bucket-terraform"   # Replace with your bucket name
    key            = "terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}

provider "aws" {
  region = var.region
}

# ===== Create S3 Bucket for Terraform Remote State =====
resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ===== Create DynamoDB Table =====
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Locks"
    Environment = var.environment
  }
}

# ===== Create EC2 Instance =====
resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-EC2"
  }
}
