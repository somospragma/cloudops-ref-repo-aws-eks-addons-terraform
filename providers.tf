###########################################
#Terraform - Providers
###########################################
terraform {
  required_providers {
    aws = {
      configuration_aliases = [aws.project]
    }
  }
}
