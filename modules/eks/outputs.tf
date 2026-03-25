output "cluster_name" {
  value = module.this_eks.cluster_name
}

output "cluster_arn" {
  value = module.this_eks.cluster_arn
}

output "managed_node_groups_iam_role_arns" {
  description = "IAM Role ARNs for all managed node groups"
  value = {
    for ng_name, ng in aws_eks_node_group.this : ng_name => ng.iam_role_arn
  }
}