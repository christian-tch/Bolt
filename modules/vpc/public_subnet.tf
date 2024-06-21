resource "aws_subnet" "public_az_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 2, 0)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = {
    type = "public"
    Name = "${var.resource_prefix}-public-subnet-a"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.public_az_a.id
  route_table_id = aws_route_table.public_subnets.id
}

resource "aws_subnet" "public_az_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 2, 1)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = {
    type = "public"
    Name = "${var.resource_prefix}-public-subnet-b"
  }
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = aws_subnet.public_az_b.id
  route_table_id = aws_route_table.public_subnets.id
}