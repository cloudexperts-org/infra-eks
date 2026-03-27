variable "github_runner_role_arn" {
  type        = string
  description = "IAM role ARN for GitHub Actions runner to access the EKS cluster"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
  default     = "dev"
}