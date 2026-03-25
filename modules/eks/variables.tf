variable "cluster_name" {
  type        = string
}

variable "region" {
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "max_capacity" {
  type    = number
  default = 3
}

variable "min_capacity" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
}

variable "aws_auth_roles" {
  description = "IAM roles to add to aws-auth"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}