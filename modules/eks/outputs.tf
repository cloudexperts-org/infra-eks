output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this[0].name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.this[0].arn
}

output "eks_managed_node_group_names" {
  description = "Names of all managed node groups"
  value       = [for ng in aws_eks_node_group.this : ng.node_group_name]
}

output "eks_managed_node_group_arns" {
  description = "ARNs of all managed node groups"
  value       = [for ng in aws_eks_node_group.this : ng.arn]
}