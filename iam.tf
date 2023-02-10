resource "aws_iam_policy" "ebs_csi_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:AttachVolume",
          "ec2:DetachVolume"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    stack     = var.stack
    managedBy = "terraform"
  }
}
