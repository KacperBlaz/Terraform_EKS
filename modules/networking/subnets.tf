resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.this.id
  for_each = var.public_subnets_cidr_blocks
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = each.value.availability_zone

  tags = {
    Environment = "${terraform.workspace}"
    Name        = "${var.tags["public_subnet_name"]}-${each.value.availability_zone}"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.this.id
  for_each = var.private_subnets_cidr_blocks
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = false


  tags = {
    Environment                       = "${terraform.workspace}"
    Name                              = "${var.tags["private_subnet_name"]}-${each.value.availability_zone}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}