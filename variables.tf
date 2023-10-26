### S3 REMOTE ###

variable "remote_bucket_name" {
  type = string
}

variable "aws_region" {
  type = string
}

### IAM ROLES ###

variable "eks_role_name" {
  type = string
}

### NETWORKING

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets_cidr_blocks" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
  default = {
    public_subnet_1 = {
      cidr_block = "172.10.10.0/24"
      availability_zone = "us-east-1a"
    }
    public_subnet_2 = {
      cidr_block = "172.10.20.0/24"
      availability_zone = "us-east-1b"
    }
    public_subnet_3 = {
      cidr_block = "172.10.30.0/24"
      availability_zone = "us-east-1c"
    }
  }
}

variable "private_subnets_cidr_blocks" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
  default = {
    private_subnet_1 = {
      cidr_block = "172.10.40.0/24"
      availability_zone = "us-east-1a"
    }
    private_subnet_2 = {
      cidr_block = "172.10.50.0/24"
      availability_zone = "us-east-1b"
    }
    private_subnet_3 = {
      cidr_block = "172.10.60.0/24"
      availability_zone = "us-east-1c"
    }
  }
}

### EKS ###

variable "eks_node_group_role_name" {
  type = string
}

variable "capacity_type" {}

variable "instance_types" {}
variable "min_size" {}
variable "desired_size" {}
variable "max_size" {}
variable "max_unavailable" {}