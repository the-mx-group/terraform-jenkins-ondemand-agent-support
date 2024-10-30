resource "aws_iam_role" "jenkins-build-agent-instance" {
  name        = "${var.name_prefix}jenkins-build-agent-instance"
  description = "Hosts dynamically created for Jenkins EC2 builders"

  tags = merge(var.tags, {
    Name = "${var.name_prefix} Jenkins Agent Instance"
  })

  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_iam_role_policy_attachment" "jenkins-build-agent-instance-ssm" {
  role = aws_iam_role.jenkins-build-agent-instance.name
  policy_arn =   "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "jenkins-build-agent-instance-ec2" {
  for_each = var.instance_profile_policies
  role = aws_iam_role.jenkins-build-agent-instance.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "jenkins-build-agent" {
  name = "${var.name_prefix}jenkins-build-agent"
  role = aws_iam_role.jenkins-build-agent-instance.name
  tags = var.tags
}
