# ── OIDC Provider ─────────────────────────────────────────────────────────────
data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  # Reads TLS certificate from EKS cluster
  # Gets the thumbprint needed for OIDC provider registration
  # Depends on EKS cluster existing first
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  # Registers EKS as an identity provider in AWS IAM
  # Allows Kubernetes service accounts to assume IAM roles
  # This is what makes IRSA work
  # Without this: pods can't get AWS credentials via service accounts

  tags = {
    Name = "${var.project_name}-${var.environment}-eks-oidc"
    Environment = var.environment
  }
}

# ── LBC IAM Policy ────────────────────────────────────────────────────────────
data "http" "lbc_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v3.4.1/docs/install/iam_policy.json"
  # Updated to match LBC v3.4.1 installed via Helm
  # v2.7.1 policy missing DescribeListenerAttributes permission
  # Downloads the official LBC IAM policy from GitHub
  # No manual file download needed
  # Always gets the correct policy for v2.7.1
  # Terraform fetches this during plan/apply automatically
}

resource "aws_iam_policy" "lbc" {
  name        = "${var.project_name}-${var.environment}-lbc-policy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = data.http.lbc_policy.response_body
  # Uses the downloaded policy directly
  # response_body = the JSON content of the URL
  # No local file needed ✅

  tags = {
    Name = "${var.project_name}-${var.environment}-lbc-policy"
    Environment = var.environment
  }
}

# ── LBC IAM Role ──────────────────────────────────────────────────────────────
resource "aws_iam_role" "lbc" {
  name = "${var.project_name}-${var.environment}-lbc-role"
  # This role is assumed by the LBC pod inside EKS
  # Gives the pod permission to create/manage AWS load balancers

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks.arn
        # Only the EKS OIDC provider can assume this role
        # Not just any AWS service or user
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      # AssumeRoleWithWebIdentity = IRSA mechanism
      # Pod presents its service account JWT token
      # AWS verifies it with OIDC provider
      # Issues temporary credentials for this role
      Condition = {
        StringEquals = {
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud" = "sts.amazonaws.com"
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          # sub = subject = which service account can use this role
          # ONLY the aws-load-balancer-controller service account
          # in the kube-system namespace can assume this role
          # No other pod can use these permissions
        }
      }
    }]
  })

  tags = {
    Name = "${var.project_name}-${var.environment}-lbc-role"
    Environment = var.environment
  }
}

# ── Attach Policy to Role ─────────────────────────────────────────────────────
resource "aws_iam_role_policy_attachment" "lbc" {
  role       = aws_iam_role.lbc.name
  policy_arn = aws_iam_policy.lbc.arn
  # Connects the policy to the role
  # Role says WHO can use it (LBC service account)
  # Policy says WHAT they can do (create load balancers)
}