output "eks_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig_cert_authority_data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

#output "eks_token" {
#  value = aws_eks_cluster.eks_cluster.token
#}