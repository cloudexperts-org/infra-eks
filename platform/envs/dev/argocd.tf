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

# EKS cluster data
data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = data.aws_eks_cluster.this.name
}

# Kubernetes provider (used by Helm)
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

# Helm provider will use the Kubernetes provider above
provider "helm" {}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = true
}