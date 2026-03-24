# Root / general
cluster_name = "my-eks-cluster"
region = "ap-southeast-1"

# VPC Module
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

# EKS Module
desired_capacity = 2
min_capacity     = 1
max_capacity     = 3
instance_type    = "t3.medium"