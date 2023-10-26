terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  required_version = ">=1.2.0"
}

provider "aws" {
  region = var.aws_region
}

output "cluster_name" {
  value = module.networking.eks_cluster_name
}

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


module "iam" {
  source        = "./modules/iam"
  eks_role_name = var.eks_role_name
  eks_node_group_role_name = var.eks_node_group_role_name
}

module "networking" {
  source                    = "./modules/networking"
  vpc_cidr_block            = var.vpc_cidr_block
  public_subnets_cidr_blocks  = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
}

module "eks" {
  source           = "./modules/eks"
  depends_on       = [module.iam, module.networking]
  eks_role_arn     = module.iam.eks_role_arn
  public_subnet_ids = module.networking.public_subnet_ids
  private_subnet_ids      = module.networking.private_subnet_ids
  node_role_arn = module.iam.eks_node_group_role_arn
  eks_cluster_name = module.networking.eks_cluster_name
  capacity_type = var.capacity_type
  instance_types = var.instance_types
  min_size = var.min_size
  desired_size = var.desired_size
  max_size = var.max_size
  max_unavailable = var.max_unavailable
}