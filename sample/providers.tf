###########################################
# Providers Configuration
###########################################

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  alias  = "principal"
  region = "us-east-1"
  
  default_tags {
    tags = {
      Client      = var.client
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "eks-addons"
    }
  }
}
