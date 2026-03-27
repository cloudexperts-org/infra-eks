# Fetch remote state of EKS cluster
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "cloudex-terraform-state-bucket"
    key    = "eks/dev/terraform.tfstate"  # path to your EKS state
    region = "ap-southeast-1"
  }
}

# AWS provider
provider "aws" {
  region = "ap-southeast-1"
}

# Local for cluster name
locals {
  cluster_name = data.terraform_remote_state.eks.outputs.cluster_name
}

# EKS data sources
data "aws_eks_cluster" "eks" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = local.cluster_name
}

# Kubernetes provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Helm provider uses Kubernetes provider automatically
provider "helm" {}

# Helm release for ArgoCD
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = true
}