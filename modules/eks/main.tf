provider "aws" {
  region = var.region
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.3.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.35"

  vpc_id            = var.vpc_id
  subnet_ids        = var.public_subnet_ids
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
 
  eks_managed_node_groups = {
    default = {
      desired_capacity = var.desired_capacity
      min_size         = var.min_capacity
      max_size         = var.max_capacity
      instance_types   = [var.instance_type]
      # iam_role_arn   = var.node_group_role_arn # optional
    }
  }

  enable_irsa = true
}