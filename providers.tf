terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}
provider "aws" {
  region  = "us-west-1"
  access_key = "****"
  secret_key = "***********"
}
