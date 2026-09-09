terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Configure your remote backend (e.g. S3) if needed:
  # backend "s3" {
  #   bucket         = "your-state-bucket"
  #   key            = "codeartifact/terraform.tfstate"
  #   region         = "ap-northeast-1"
  #   encrypt        = true
  #   use_lockfile   = true
  # }
}
