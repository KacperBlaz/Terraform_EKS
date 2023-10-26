resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Environment                                   = "${terraform.workspace}"
    Name                                          = var.tags["VPC_Name"]
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
}