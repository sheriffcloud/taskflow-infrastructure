# ── Download LBC policy automatically ────────────────────────────────────────
data "http" "lbc_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.1/docs/install/iam_policy.json"
  # Terraform downloads this URL automatically
  # No manual file download needed
  # Always gets the correct version
}

resource "aws_iam_policy" "lbc" {
  name        = "${var.project_name}-${var.environment}-lbc-policy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = data.http.lbc_policy.response_body
  # Uses the downloaded policy directly
  # No local file needed ✅
}