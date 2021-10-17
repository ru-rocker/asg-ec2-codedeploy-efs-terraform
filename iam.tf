resource "aws_iam_instance_profile" "iam_code_deploy_instance_profile" {
  name = "${var.project_name}-CodeDeploy-InstanceProfile"
  role = aws_iam_role.code_deploy_role.name
}

resource "aws_iam_role" "code_deploy_role" {
  name = "${var.project_name}-CodeDeploy-InstanceProfile"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          Service : "ec2.amazonaws.com"
        },
        Effect : "Allow"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.s3_access.arn]
}

resource "aws_iam_policy" "s3_access" {
  name = "${var.project_name}-CodeDeploy-EC2-S3-Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:Get*", "s3:List*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "code_deploy_service_role" {
  name = "${var.project_name}-CodeDeploy-ServiceRole"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          Service : "codedeploy.amazonaws.com"
        },
        Effect : "Allow"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole",
  ]
}
