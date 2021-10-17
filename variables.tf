variable "project_name" {
  default = "myproject"
  description = "Project Name"
}

variable "vpc_id" {
    description = "VPC ID"
}

variable "alb_subnet_id" {
    description = "Subnet ID"
}

variable "ec2_subnet_id" {
  type = set(string)
  description = "Subnet ID"
}

variable "ami_image_id" {
  default = "ami-XXXXX"
  description = "AMI"
}

variable "launch_template_name" {
  default = "myproject-launch-template"
  description = "Name of launch template"
}

variable "instance_type" {
  default = "t2.medium"
  description = "Instance Type"
}

variable "required_tags" {
  description = "Required tags"
}

variable "key_name" {
  default = "my.keypair"
  description = "Key Name"
}

variable "email_subscriber" {
  description = "Email for SNS notification"
  default = "a@b.com"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
}

variable "env" {
  description = "environment (sit|prod)"
}

variable "instance_market_type" {
  description = "Instance Market Type. Spot or OnDemand"
}

variable "efs_mount_point_1" {
  description = "FS mount point in instance"
  default = "/shared"
}

variable "efs_wildfly_folder" {
  description = "FS mount point for wildfly user. Please mention the efs_mount_point_1 folder as prefix!"
  default = "/shared/wildfly"
}