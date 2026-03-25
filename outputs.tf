output "vpc_id" {
  value = module.vpc.vpc_id
}


output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "eks_managed_node_group_iam_roles" {
  value = { for k, v in module.eks.managed_node_groups : k => v.iam_role_arn }
}