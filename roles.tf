resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role_for_notebook"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })
}

# Use custom policy 
resource "aws_iam_policy" "s3_access_policy" {
  name = "CustomS3AccessPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
      {
        Action   = "ssm:GetParameter"
        Effect   = "Allow"
        Resource = "arn:aws:ssm:us-east-1:422182319906:${var.parameter_name}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_read_only_custom" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
