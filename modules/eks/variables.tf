variable "eks_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "eks_cluster_name" {}

variable "node_role_arn" {
  type = string
}

variable "capacity_type" {}
variable "instance_types" {}
variable "min_size" {}
variable "desired_size" {}
variable "max_size" {}
variable "max_unavailable" {}