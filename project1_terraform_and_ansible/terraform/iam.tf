resource "aws_iam_role" "ec2_role" {
  name = "EC2MonitoringRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "s3_read_only" {
  name        = "S3ReadOnlyPolicy"
  description = "Read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = ["s3:Get*", "s3:List*"]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}
