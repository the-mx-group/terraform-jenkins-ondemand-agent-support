resource "aws_security_group" "jenkins-build-agent" {

  name   = "${var.name_prefix}jenkins-build-agent"
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}jenkins-build-agent"
  })

  dynamic "ingress" {
    for_each = length(var.source_blocks) > 0 ? [1] : []
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = var.source_blocks
    }
  }

  dynamic "ingress" {
    for_each = length(var.source_groups) > 0 ? [1] : []
    content {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = var.source_groups
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
