terraform {
  required_version = "~> 1.5.7"

  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.22.0" }
    helm = { source = "hashicorp/helm", version = "~> 2.16" }
  }

  backend "s3" {
    bucket         = "cloudex-terraform-state-bucket"
    key            = "eks/dev/terraform.tfstate"  # can make dynamic later
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}