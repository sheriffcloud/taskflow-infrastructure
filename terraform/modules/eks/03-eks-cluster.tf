resource "aws_eks_cluster" "eks_cluster" {
  name = "${var.project_name}-${var.environment}-eks-cluster"

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.eks_nodes_security_group_id]
    endpoint_private_access = true
    endpoint_public_access  = true
    # Allow kubectl commands from OUTSIDE the VPC
    # This lets you run kubectl from your laptop
    # In strict production you would set this false
    # and only allow access from within VPC
    # We keep it true for ease of learning
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]



  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy_attachment,
    aws_iam_role_policy.eks_cluster_cloudwatch,
  ]

    tags = {
        Name        = "${var.project_name}-${var.environment}-eks-cluster"
        Environment = var.environment
    }
}