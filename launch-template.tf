data "template_file" "userdata" {
  template = "${file("sit/user-data.sh.tpl")}"

  vars = {
    file_system_id_1 = aws_efs_file_system.efs.id
    efs_mount_point_1 = var.efs_mount_point_1
    efs_wildfly_folder = var.efs_wildfly_folder
  }
}

resource "aws_launch_template" "launch_template" {
  
  name = var.launch_template_name
  
  image_id = var.ami_image_id
  instance_type = var.instance_type
  key_name = var.key_name

  iam_instance_profile {
      arn = aws_iam_instance_profile.iam_code_deploy_instance_profile.arn
  }

  vpc_security_group_ids = [
    aws_security_group.allow_8080.id, 
    aws_security_group.allow_ssh.id
  ]

  tag_specifications {
    resource_type = "instance"
    tags = var.required_tags
  }

  user_data = base64encode(data.template_file.userdata.rendered)
}