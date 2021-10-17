resource "aws_sns_topic" "code_deploy" {
  name       = "${var.project_name}-CodeDeploy-SNS"
  tags       = var.required_tags  
}

resource "aws_sns_topic_subscription" "code_deploy_subscription" {
  topic_arn = aws_sns_topic.code_deploy.arn
  protocol  = "email"
  endpoint  = var.email_subscriber
}
