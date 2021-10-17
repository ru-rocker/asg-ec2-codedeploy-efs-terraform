# Overview
Infrastructure as a Code for ASG using EC2, Launch Template,
EFS, SNS, Instance Profile and Code Deploy.


# Project Structure
All files is divided based on AWS resources,.

# Steps
Steps to execute:

     terraform init # initialized terraform project
     terraform plan -var-file="dev/terraform.tfvars"
     terraform apply -var-file="dev/terraform.tfvars"
     terraform destroy -var-file="dev/terraform.tfvars"

_Note: variables are split based on environment._

# Debugging
Sometimes, you need to debug your executions. Please export *TF_LOG* into your environment variables.
The values are: *TRACE*, *DEBUG*, *INFO*, *WARN*, *ERROR*

     # example enable DEBUG
     export TF_LOG=DEBUG

