data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks_cluster.version}/amazon-linux-2/recommended/release_version"
}

locals {
  nodegroup_name = "EKS_NodeGroup-${terraform.workspace}"
}

output "test_policy_arn" {
  value = aws_iam_role.test_oidc
}