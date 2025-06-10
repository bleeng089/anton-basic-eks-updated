terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest version if possible
    }
 
  }

  backend "s3" {
    bucket  = "walid-backend-089.com" # Name of the S3 bucket
    key     = "terraform.tfstate"           # The name of the state file in the bucket
    region  = "us-east-1"                # Use a variable for the region
    encrypt = true                       # Enable server-side encryption (optional but recommended)
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}