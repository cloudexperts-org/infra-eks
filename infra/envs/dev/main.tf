module "vpc" {
  source       = "../../../modules/vpc"
  cluster_name = var.cluster_name
  region       = var.region
}

module "eks" {
  source       = "../../../modules/eks"
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.public_subnet_ids
  vpc_id       = module.vpc.vpc_id

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
}

module "iam" {
  source       = "../../../modules/iam"
  cluster_name = var.cluster_name
  cluster_arn  = module.eks.cluster_arn

  depends_on = [module.eks]
}