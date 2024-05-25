terraform {
  backend "s3" {
    bucket         = "storybooks-devops-tf"
    key            = "tfstate/terraform.tfstate"
    region         = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51"
    }
  }
}