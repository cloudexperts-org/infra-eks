module "vpc" {
  source = "./modules/vpc"
  cluster_name = var.cluster_name
  region       = "ap-southeast-1"
}

module "eks" {
  source = "./modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      min_size         = 1
      max_size         = 3
      instance_types   = ["t3.medium"]
    }
  }
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = module.eks.cluster_name
  cluster_arn  = module.eks.cluster_arn
}
