variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "bucket for storing terraform statefile"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for terraform locking"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-02b8269d5e85954ef" # Amazon Linux 2023 for ap-south-1
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
