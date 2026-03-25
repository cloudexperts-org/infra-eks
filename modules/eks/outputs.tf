output "cluster_name" {
  value = module.this_eks.cluster_name
}

output "cluster_arn" {
  value = module.this_eks.cluster_arn
}


output "eks_managed_node_group_names" {
  value = module.this_eks.eks_managed_node_groups
}
