resource "aws_eip" "nat" {
    count = length(var.availability_zones)
    domain   = "vpc"
    depends_on = [ aws_internet_gateway.main ]
  
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-eip-${count.index + 1}"
    Environment = var.environment
  }
}


resource "aws_nat_gateway" "main" {
  count = length(var.availability_zones)
  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat[count.index].id

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway-${count.index + 1}"
    Environment = var.environment
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}