terraform {
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.51"
    }
  }
  
  required_version = ">= 1.0"
}