variable "vpc_cidr_block" {
  type = string
}

variable "cluster_name" {}

variable "public_subnets_cidr_blocks" {}

variable "private_subnets_cidr_blocks" {}


variable "tags" {
  type        = map(any)
  description = "Tags for Networking resources"

  default = {
    VPC_Name                  = "VPC_EKS"
    IGW_Name                  = "IGW_VPC_EKS"
    NAT_GW_Name               = "EKS_NAT_GW"
    EKS_EIP_NAME              = "EKS_EIP"
    EKS_internet_access_route = "EKS-Access-Internet"
    public_subnet_name        = "EKS_Public_Subnet"
    private_subnet_name       = "EKS_Private_Subnet"
  }
}