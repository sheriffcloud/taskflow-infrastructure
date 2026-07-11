resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  count = length(var.availability_zones)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-${count.index + 1}"
    Environment = var.environment
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}-eks" = "shared"
  }
}