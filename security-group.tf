resource "aws_security_group" "build-agent" {

  name   = "${var.name_prefix}jenkins-build-agent"
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "${var.name_prefix}jenkins-build-agent"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.source_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
