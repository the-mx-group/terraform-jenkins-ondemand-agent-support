resource "aws_key_pair" "jenkins-build-agent-ssh-key" {
  key_name   = "${var.name_prefix}jenkins-build-agent-ssh-key"
  public_key = var.ssh_pubkey
}
