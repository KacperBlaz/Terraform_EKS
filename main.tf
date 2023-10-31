locals {
  cluster_name = "EKS-cluster-${terraform.workspace}"
}

module "iam" {
  source                   = "./modules/iam"
  eks_role_name            = var.eks_role_name
  eks_node_group_role_name = var.eks_node_group_role_name
  eks_aws_console_access = var.eks_aws_console_access
}

module "networking" {
  source                      = "./modules/networking"
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnets_cidr_blocks  = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  cluster_name                = local.cluster_name
}

module "eks" {
  source             = "./modules/eks"
  depends_on         = [module.iam, module.networking]
  eks_role_arn       = module.iam.eks_role_arn
  node_role_arn      = module.iam.eks_node_group_role_arn
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  eks_cluster_name   = local.cluster_name
  capacity_type      = var.capacity_type
  instance_types     = var.instance_types
  min_size           = var.min_size
  desired_size       = var.desired_size
  max_size           = var.max_size
  max_unavailable    = var.max_unavailable
}

resource "null_resource" "load_eks_kubeconfig" {
  depends_on = [module.eks]
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.cluster_name}"
  }
}

resource "kubernetes_config_map" "aws_auth_configmap" {
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }
  data = {
        mapRoles = yamlencode(
          [
    {
        "groups": [
            "system:bootstrappers",
            "system:nodes"
        ],
        "rolearn": "arn:aws:iam::410040632229:role/EKS-Node-Group-Role-default",
        "username": "system:node:{{EC2PrivateDNSName}}"
    }
])
        mapUsers = <<YAML
- userarn: arn:aws:iam::410040632229:root
  groups:
  - system:masters
YAML
  }
}