# ── OIDC Provider ─────────────────────────────────────────────────────────────
data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  # Reads the TLS certificate from the EKS cluster
  # Needed to register the OIDC provider
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  # Creates the OIDC provider automatically
  # Links EKS cluster identity to AWS IAM
  # Required for IRSA (IAM Roles for Service Accounts)
}

# ── LBC IAM Policy ────────────────────────────────────────────────────────────
resource "aws_iam_policy" "lbc" {
  name        = "${var.project_name}-${var.environment}-lbc-policy"
  description = "IAM policy for AWS Load Balancer Controller"

  policy = file("${path.module}/lbc-policy.json")
  # Reads the policy from a local file
  # We'll add lbc-policy.json to the eks module folder
}

# ── LBC IAM Role ──────────────────────────────────────────────────────────────
resource "aws_iam_role" "lbc" {
  name = "${var.project_name}-${var.environment}-lbc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud" = "sts.amazonaws.com"
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lbc" {
  role       = aws_iam_role.lbc.name
  policy_arn = aws_iam_policy.lbc.arn
}