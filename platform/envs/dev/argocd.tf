
provider "aws" {
  region = "ap-southeast-1"
}

# EKS cluster data
data "aws_eks_cluster" "eks" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = data.aws_eks_cluster.eks.name
}

# Kubernetes provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Helm provider (will use the default Kubernetes provider)
provider "helm" {}

# Helm release for ArgoCD
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = true
}