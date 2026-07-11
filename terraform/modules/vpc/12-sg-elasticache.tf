resource "aws_security_group" "elasticache" {
  name        = "${var.project_name}-${var.environment}-elasticache-sg"
  description = "Controls traffic to and from ElastiCache Redis"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow Redis traffic from EKS nodes"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_nodes.id]
  }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "${var.project_name}-${var.environment}-elasticache-sg"
    Environment = var.environment
  }
}