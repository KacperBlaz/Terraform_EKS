output "eks_role_arn" {
  value = module.iam.eks_role_arn
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "eks_endpoint" {
  value = module.eks.eks_endpoint
}

output "kubeconfig_cert_authority_data" {
  value = module.eks.kubeconfig_cert_authority_data
}

output "eks_node_group_role_arn" {
  value = module.iam.eks_node_group_role_arn
}