module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.3.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.35"

  # Provide VPC and subnets
  vpc_id     = module.vpc.vpc_id
  subnet_ids = var.subnet_ids

  # Managed node groups (v20 syntax)
  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      min_size         = 1
      max_size         = 3
      instance_types   = ["t3.medium"]
    }
  }

  enable_irsa = true
}