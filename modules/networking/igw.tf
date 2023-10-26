resource "aws_internet_gateway" "vpc_eks_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Environment = "${terraform.workspace}"
    Name        = var.tags["IGW_Name"]
  }
}