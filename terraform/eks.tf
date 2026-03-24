# ---------------------------
# EKS Module
# ---------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.3.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.35"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access        = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = ["t3.medium"]
    }
  }

  enable_irsa = true

  # Add your IAM user directly here
  aws_auth_users = [
    {
      user_arn = "arn:aws:iam::865809098262:user/akash"
      username = "akash"
      groups   = ["system:masters"]
    }
  ]

}