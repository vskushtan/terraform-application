variable "name_sg" {
    description = "The name of the SG"
    type = string
}

variable "vpc_id" {
    description = "The VPC ID"
    type = string
}

# variable "from_port" {
#     description = "The start range of the inbound port rule"
#     type = number
# }

# variable "to_port" {
#     description = "The start range of the outbound port rule"
#     type = number
# }

variable "cidr_blocks" {
    description = "The CIDR Blocks for inbound traffic"
    type = string
}

variable "ingress_rules" {
  description = "List of ports for ingress rules"
  type        = list(object({
    from_port = number
    to_port   = number
  }))
}

variable "egress_rules" {
  description = "List of egress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}