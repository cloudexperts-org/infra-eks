# EKS module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.35"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  endpoint_public_access  = true
  endpoint_private_access = true   # keep private for VPC workloads
  public_access_cidrs     = ["0.0.0.0/0"] # or restrict to GitHub runner IPs

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = ["t3.medium"]
    }
  }

  enable_irsa = true
}