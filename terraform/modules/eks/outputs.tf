output "eks_cluster_name" {
    description = "The name of the EKS cluster"
    value = aws_eks_cluster.eks_cluster.name 
}

output "eks_cluster_endpoint" {
    description = "The endpoint URL of the EKS cluster"
    value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate" {
    description = "Base64 encoded certificate for cluster authentication"
    value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
    sensitive = true
  
}

output "eks_node_security_group_id" {
    description = "Security group ID attached to worker nodes"
    value = var.eks_nodes_security_group_id
}

output "configure_kubectl" {
    description = "Command to configure kubectl to connect to this cluster"
    value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.eks_cluster.name}"
}