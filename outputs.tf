output "vpc_id" {
  value = ""
  description = "The VPC in which the security group lives"
}
output "security_group_name" {
  value = ""
  description = "The name of the security group for nodes"
}
output "ssh_private_key" {
  value = ""
  description = "The SSH private key to use to connect to the nodes.  If you provided a public key input, this will be blank."
}
output "instance_profile" {
  value = ""
  description = "The ARN of the instance profile to be used on nodes"
}
output "access_key" {
  value = ""
  description = "The IAM access key which Jenkins will use to create instances"
}
output "access_secret" {
  value = ""
  description = "The IAM secret which Jenkins will use to create instances"
}