variable "ami_name_filter" {
  description = "The AMI name for filter"
  type = string
}

variable "instance_type" {
 description = "Instance Type"
 type = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_groups_name" {
  description = "SG Name"
  type        = string
}
variable "instance_name" {
  description = "Instance Name"
  type        = string
}

variable "instance_role" {
  description = "Instance Role"
  type        = string
}

variable "instance_env" {
  description = "Instance Env"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to associate with the EC2 instance"
  type = string
}