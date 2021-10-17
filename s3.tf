resource "aws_s3_bucket" "deployment_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  tags   = var.required_tags
}
