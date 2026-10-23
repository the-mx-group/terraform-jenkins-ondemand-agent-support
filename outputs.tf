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
output "controller_agent_manager_role_arn" {
  value       = try(aws_iam_role.jenkins-controller-agent-manager[0].arn, null)
  description = "ARN of the role the Jenkins controller assumes to launch agents (EC2 cloud roleArn), or null if controller_role_arns is empty"
}
