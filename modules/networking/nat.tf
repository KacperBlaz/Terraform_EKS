resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = var.tags["EKS_EIP_NAME"]
  }
}

resource "aws_nat_gateway" "access_public" {
  allocation_id = aws_eip.nat.id
  subnet_id     = "subnet-0d5d03d27000de371"

  tags = {
    Name = var.tags["NAT_GW_Name"]
  }
}