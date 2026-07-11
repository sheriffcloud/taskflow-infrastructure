resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  count = length(var.availability_zones)
#   map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-${count.index + 1}"
    Environment = var.environment
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}-eks" = "shared"
  }
}