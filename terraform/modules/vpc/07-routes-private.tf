resource "aws_route_table" "private" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }


  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}


resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "database" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}