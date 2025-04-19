terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = var.bucket
    key = var.key
    region = var.region
  }
}

provider "aws" {
  region = var.region
}

