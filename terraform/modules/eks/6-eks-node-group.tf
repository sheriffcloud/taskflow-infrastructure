resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.project_name}-${var.environment}-eks-node-group"
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = var.private_subnet_ids

  # instance_types = [var.eks_node_instance_type]
  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version
  }

  scaling_config {
    desired_size = var.eks_node_desired_size
    max_size     = var.eks_node_max_size
    min_size     = var.eks_node_min_size
  }

  update_config {
    max_unavailable = 1
  }

  ami_type = "AL2023_x86_64_STANDARD"
  capacity_type = "ON_DEMAND"

  
  labels = {
    environment = var.environment
    project     = var.project_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_registry_policy_attachment,
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-node-group"
    Environment = var.environment
  }
}