data "aws_caller_identity" "current" {}
data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
data "aws_iam_policy_document" "lambda_execution_policy_document" {
    statement {
        actions = ["logs:CreateLogGroup"]
        effect = "Allow"
        resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
    }
    statement {
      actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
      effect = "Allow"
      resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.unique_id}-function:*"]
    }
}
data "aws_iam_policy_document" "lambda_ssm_policy_document" {
    statement {
        actions = [
            "ssm:GetParameterHistory",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "ssm:GetParameter"
        ]
        effect = "Allow"
        resources = [
            "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/*"
        ]
    }
}
data "aws_iam_policy_document" "lambda_s3_policy_document" {
    statement {
      actions = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion"
      ]
      effect = "Allow"
      resources = ["${aws_s3_bucket.bucket.arn}/*"]
    }
}
data "aws_iam_policy_document" "lambda_securityhub_policy_document" {
    statement {
      actions = [
          "securityhub:GetFindings"
      ]
      effect = "Allow"
      resources = ["arn:aws:securityhub:${var.region}:${data.aws_caller_identity.current.account_id}:hub/default"]
    }
    statement {
        actions = [
            "securityhub:BatchImportFindings"
        ]
        effect = "Allow"
        resources = ["arn:aws:securityhub:${var.region}:517716713836:product/crowdstrike/*"]
    }
}

resource "aws_iam_policy" "lambda_ssm_policy" {
  name        = "${var.unique_id}_ssm_policy"
  policy      = data.aws_iam_policy_document.lambda_ssm_policy_document.json
}
resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "${var.unique_id}_execution_policy"
  policy      = data.aws_iam_policy_document.lambda_execution_policy_document.json
}
resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "${var.unique_id}_s3_policy"
  policy      = data.aws_iam_policy_document.lambda_s3_policy_document.json
}
resource "aws_iam_policy" "lambda_securityhub_policy" {
  name        = "${var.unique_id}_securityhub_policy"
  policy      = data.aws_iam_policy_document.lambda_securityhub_policy_document.json
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.unique_id}-execution-role" 
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
resource "aws_iam_policy_attachment" "lambda_ssm_policy_attach" {
	name = "${var.unique_id}_ssm-policy-attachment"
	roles = [aws_iam_role.iam_for_lambda.name]
	policy_arn = aws_iam_policy.lambda_ssm_policy.arn
}
resource "aws_iam_policy_attachment" "lambda_exec_policy_attach" {
	name = "${var.unique_id}_lambda-exec-policy-attachment"
	roles = [aws_iam_role.iam_for_lambda.name]
	policy_arn = aws_iam_policy.lambda_execution_policy.arn
}
resource "aws_iam_policy_attachment" "lambda_s3_policy_attach" {
	name = "${var.unique_id}_lambda-s3-policy-attachment"
	roles = [aws_iam_role.iam_for_lambda.name]
	policy_arn = aws_iam_policy.lambda_s3_policy.arn
}
resource "aws_iam_policy_attachment" "lambda_securityhub_policy_attach" {
	name = "${var.unique_id}_lambda-securityhub-policy-attachment"
	roles = [aws_iam_role.iam_for_lambda.name]
	policy_arn = aws_iam_policy.lambda_securityhub_policy.arn
}
