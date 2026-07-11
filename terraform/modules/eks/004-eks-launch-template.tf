resource "aws_launch_template" "eks_nodes" {
  name = "${var.project_name}-${var.environment}-eks-node-template"

  # Attach our custom security group
  vpc_security_group_ids = [var.eks_nodes_security_group_id]

  # Instance type
  instance_type = var.eks_node_instance_type

  # Add metadata options required for EKS nodes
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    # IMDSv2 required — more secure than IMDSv1
    # Prevents SSRF attacks from stealing node credentials
    http_put_response_hop_limit = 2
    # hop_limit = 2 is required for containers to access
    # instance metadata — needed by AWS SDK inside pods
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project_name}-${var.environment}-eks-node"
      Environment = var.environment
      Project     = var.project_name
    }
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-node-template"
  }
}