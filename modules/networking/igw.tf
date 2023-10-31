resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Environment = terraform.workspace
    Name        = var.tags["IGW_Name"]
  }
}