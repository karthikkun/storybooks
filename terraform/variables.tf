variable "app_name" {
  description = "Application Name"
  default     = "storybooks"
}

variable "region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
}

variable "shared_credentials_files" {
    description = "aws shared credentials file path"
    type = list
}

variable "profile" {
  description = "The AWS profile to create resources in."
  type = string
  default = "default"
}

variable "ami_id" {
  description = "The AMI ID to use for the server."
  default = "ami-011899242bb902164"
}

variable "instance_type" {
  description = "AWS EC2 Instance Type"
  default = "t2.micro"
}

variable "env" {
  description = "The AWS profile to create resources in."
  default     = "sandbox"
}