env = "sit"
vpc_id = "vpc-XXXX"
alb_subnet_id = ["subnet-XXX","subnet-YYY","subnet-ZZZ"]
ec2_subnet_id = ["subnet-XXX","subnet-YYY","subnet-ZZZ"]
bucket_name = "my-deployment-bucket"

required_tags = {
    "src.projectKey" = "poc"
    "Name"           = "jdk11-Wildfly24"
}

instance_market_type = ["spot"]

instance_type = "t3a.large"