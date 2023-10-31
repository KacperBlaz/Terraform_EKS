resource "aws_eip" "this" {
  vpc = true

  tags = {
    Name = var.tags["EKS_EIP_NAME"]
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  depends_on = [aws_internet_gateway.this, aws_subnet.public_subnet]
  subnet_id     = values(aws_subnet.public_subnet)[0].id

  tags = {
    Name = var.tags["NAT_GW_Name"]
  }

}