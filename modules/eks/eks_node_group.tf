resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = local.nodegroup_name
  node_role_arn = var.node_role_arn
  subnet_ids =  var.private_subnet_ids
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  version = aws_eks_cluster.eks_cluster.version
  capacity_type = var.capacity_type
  instance_types = var.instance_types
  scaling_config {
    min_size = var.min_size
    desired_size = var.desired_size
    max_size = var.max_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }
  
  tags = {
    Environment                       = "${terraform.workspace}"
  }
}