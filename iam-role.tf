# A role the MX Jenkins controller assumes to launch agents in this account, instead of using the IAM
# user's long-lived access key. The controller runs as an ECS task role in the MX devops account; trusting
# that role here is all the controller needs (EC2 cloud settings: blank credentialsId, plus roleArn).
# Set controller_role_arns = [] to not create it.
resource "aws_iam_role" "jenkins-controller-agent-manager" {
  count       = length(var.controller_role_arns) > 0 ? 1 : 0
  name        = "${var.name_prefix}jenkins-controller-agent-manager"
  path        = "/cicd/"
  description = "Assumed by the MX Jenkins controller to launch build agents in this account"
  tags        = var.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = var.controller_role_arns }
      },
    ]
  })
}

resource "aws_iam_role_policy" "jenkins-controller-agent-manager-policy" {
  count  = length(var.controller_role_arns) > 0 ? 1 : 0
  name   = "${var.name_prefix}jenkins-controller-agent-manager-policy"
  role   = aws_iam_role.jenkins-controller-agent-manager[0].id
  policy = local.agent_manager_policy
}

resource "aws_iam_role_policy" "jenkins-controller-agent-manager-spot-policy" {
  count  = length(var.controller_role_arns) > 0 && var.allow_spot_instances ? 1 : 0
  name   = "${var.name_prefix}jenkins-controller-agent-manager-spot-policy"
  role   = aws_iam_role.jenkins-controller-agent-manager[0].id
  policy = local.agent_manager_spot_policy
}
