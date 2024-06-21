resource "aws_internet_gateway" "egress" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.resource_prefix}-internet-gateway"
  }
}