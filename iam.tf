resource "aws_iam_policy" "policy" {
  count       = var.IAM_INSTANCE_PROFILE ? 1:0
  name        = "${var.ENV}-${var.COMPONENT}-secret-manager-reader-policy"
  path        = "/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Resource" : "arn:aws:secretsmanager:us-east-1:697140473466:secret:roboshop-3wTSpx"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "role" {
  count       = var.IAM_INSTANCE_PROFILE ? 1:0
  name = "${var.COMPONENT}-${var.ENV}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy-role-attach" {
  count       = var.IAM_INSTANCE_PROFILE ? 1:0
  role       = aws_iam_role.role.*.name[0]
  policy_arn = aws_iam_policy.policy.*.arn[0]
}

resource "aws_iam_instance_profile" "test_profile" {
  count       = var.IAM_INSTANCE_PROFILE ? 1:0
  name = "${var.COMPONENT}-${var.ENV}"
  role = aws_iam_role.role.*.name[0]
}