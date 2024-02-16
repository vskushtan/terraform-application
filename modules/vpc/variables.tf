variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  #  default     = "10.0.0.0/16"
  type = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "av_zone" {
  description = "List of Aavailability Zone in the region"
  type        = list(string)
}

