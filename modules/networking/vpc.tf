resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Environment                                   = terraform.workspace
    Name                                          = var.tags["VPC_Name"]
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}