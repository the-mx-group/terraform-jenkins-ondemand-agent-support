resource "aws_iam_user" "jenkins-build-agent-manager" {
  name = "${var.name_prefix}jenkins-build-agent-manager"
  path = "/cicd/"
  tags = var.tags
}

resource "aws_iam_access_key" "jenkins-build-agent-manager" {
  user = aws_iam_user.jenkins-build-agent-manager.name
}

# What the Jenkins controller may do to launch agents. Shared by the IAM user (static key) and the
# role the MX controller assumes (see iam-role.tf), so the two can't drift apart.
locals {
  agent_manager_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "Stmt1312295543082"
        Action = [
          "ec2:GetConsoleOutput",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeRegions",
          "ec2:DescribeImages",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "iam:ListInstanceProfilesForRole",
          "iam:PassRole",
          "ec2:GetPasswordData",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  agent_manager_spot_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "Stmt1312295543082"
        Action = [
          "ec2:DescribeSpotInstanceRequests",
          "ec2:CancelSpotInstanceRequests",
          "ec2:RequestSpotInstances",
          "ec2:DescribeSpotPriceHistory",
          "ec2:RequestSpotFleet",
          "ec2:CancelSpotFleetRequests",
          "ec2:DescribeSpotFleetRequests",
          "ec2:DescribeSpotFleetInstances",
          "ec2:DescribeSpotInstanceRequests",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy" "jenkins-build-agent-manager-policy" {
  name   = "${var.name_prefix}jenkins-build-agent-manager-policy"
  user   = aws_iam_user.jenkins-build-agent-manager.name
  policy = local.agent_manager_policy
}

resource "aws_iam_user_policy" "jenkins-build-agent-manager-spot-policy" {
  count  = var.allow_spot_instances ? 1 : 0
  name   = "${var.name_prefix}jenkins-build-agent-manager-spot-policy"
  user   = aws_iam_user.jenkins-build-agent-manager.name
  policy = local.agent_manager_spot_policy
}
