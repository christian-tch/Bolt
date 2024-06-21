output "public_subnet_a_id" {
  value = aws_subnet.public_az_a.id
}

output "public_subnet_a_cidr_block" {
  value = aws_subnet.public_az_a.cidr_block
}

output "public_subnet_b_id" {
  value = aws_subnet.public_az_b.id
}

output "public_subnet_b_cidr_block" {
  value = aws_subnet.public_az_b.cidr_block
}
output "vpc_id" {
  value = aws_vpc.main.id
}