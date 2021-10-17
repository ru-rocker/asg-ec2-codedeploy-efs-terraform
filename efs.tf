resource "aws_efs_file_system" "efs" {
  encrypted = true
  tags = {
    Name = "AZDiscove-NFS"
  }
}

resource "time_sleep" "wait_for_efs_seconds" {
  depends_on = [aws_efs_file_system.efs]

  create_duration = "300s"
}
resource "aws_efs_mount_target" "efs_target" {
  for_each = var.ec2_subnet_id
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.value
  security_groups = [
    aws_security_group.allow_nfs.id
  ]
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id

  backup_policy {
    status = "ENABLED"
  }
}

output "efs_id" {
  value = aws_efs_file_system.efs.id
}