data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket    = "cloudex-terraform-state-bucket"
    key       = "eks/dev/terraform.tfstate"  # match actual S3 object
    region    = "ap-southeast-1"
  }
}

data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      # Node group role (VERY IMPORTANT — don’t remove!)
      {
        rolearn = "arn:aws:iam::865809098262:role/GitHubRunnerRole"
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
      },

      # GitHub Actions role
      {
        rolearn  = "arn:aws:iam::865809098262:role/GitHubRunnerRole"
        username = "github"
        groups   = ["system:masters"]
      }
    ])
  }

}