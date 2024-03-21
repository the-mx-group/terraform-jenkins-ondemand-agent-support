variable "vpc_id" {
  type = string
  description = "Configures which VPC the build nodes should be created in."
}

variable "name_prefix" {
  type = string
  description = "Prefix which should be used for all resources created by this module"
}

variable "source_blocks" {
  type = list(string)
  default = []
  description = "IP blocks which should be allowed to connect to the build hosts via SSH"
}

variable "ssh_pubkey" {
	type = string
	description = "The SSH public key to use to connect to agent instances."
}

variable "allow_spot_instances" {
  type    = bool
  default = true
  description = "Controls whether the permissions for the control user include creation of spot requests (vs ondemand).  Note that you must have already created a service linked role for spot.amazonaws.com to use this feature."
}

variable "instance_profile_policies" {
	type = list(string)
	default = []
	description = "Specifies additional managed policies to attach to the instance profile for agent nodes."
}

variable "tags" {
  type = map(string)
  default = {}
  description = "A map of tags to apply to all resources created by this module"
}