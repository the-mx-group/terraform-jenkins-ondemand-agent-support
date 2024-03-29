output "security_group_name" {
  value = aws_security_group.jenkins-build-agent.name
  description = "The name of the security group for nodes"
}
output "security_group_id" {
  value = aws_security_group.jenkins-build-agent.id
  description = "The ID of the security group for nodes"
}
output "instance_profile" {
  value = aws_iam_instance_profile.jenkins-build-agent.arn
  description = "The ARN of the instance profile to be used on nodes"
}
output "access_key" {
  value = aws_iam_access_key.jenkins-build-agent-manager.id
  description = "The IAM access key ID which Jenkins will use to create instances"
}
output "access_secret" {
  value = aws_iam_access_key.jenkins-build-agent-manager.secret
  description = "The IAM secret which Jenkins will use to create instances"
}
output "instance_iam_role_arn" {
  value = aws_iam_role.jenkins-build-agent-instance.arn
  description = "The ARN of the role that nodes with this instance profile will assume"
}