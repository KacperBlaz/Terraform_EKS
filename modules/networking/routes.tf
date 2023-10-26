resource "aws_route_table" "private_subnet_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.access_public.id
  }
}

resource "aws_route_table" "public_subnet_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_eks_igw.id
  }

  tags = {
    Name = var.tags["EKS_internet_access_route"]
  }
}

resource "aws_route_table_association" "Public_Internet_Access" {
  for_each = var.public_subnets_cidr_blocks
  route_table_id = aws_route_table.public_subnet_route.id
  depends_on = [ aws_internet_gateway.vpc_eks_igw,aws_subnet.public_subnet ]
  subnet_id = aws_subnet.public_subnet[each.key].id
}

resource "aws_route_table_association" "NAT_Route_Table_Access" {
  for_each = var.private_subnets_cidr_blocks
  route_table_id = aws_route_table.private_subnet_route.id
  depends_on = [ aws_subnet.private_subnet, aws_nat_gateway.access_public ]
  subnet_id = aws_subnet.private_subnet[each.key].id
}