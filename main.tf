terraform {
  backend "s3" {
    bucket         = "vsk-state-bucket"
    dynamodb_table = "state-lock"
    key            = "application.tfstate"
    encrypt        = true
    region         = "eu-north-1"

  }
}

provider "aws" {
  region = "eu-north-1"
}

module "my_vpc" {
  source          = "./modules/vpc"
  vpc_name        = "RD-VPC"
  av_zone         = ["eu-north-1a", "eu-north-1b"]
  public_subnets  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets = ["192.168.3.0/24", "192.168.4.0/24"]
  vpc_cidr        = "192.168.0.0/20"

}

module "sg" {
  source      = "./modules/sg"
  name_sg     = "public-sg"
  vpc_id      = module.my_vpc.vpc_id
  cidr_blocks = "0.0.0.0/0"
  ingress_rules = [
    { from_port = 3000, to_port = 3000 },
    { from_port = 22, to_port = 22 },
  ]
  egress_rules = [
  { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}

# module "jenkins-controller" {
#   source               = "./modules/ec2"
#   count                = 1
#   instance_type        = "t3.medium"
#   instance_env         = "prod"
#   instance_name        = "jenkins-controller"
#   instance_role        = "jenkins"
#   subnet_id            = module.my_vpc.public_subnets_ids[0]
#   security_groups_name = module.sg.sg_id
#   ami_name_filter      = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
#   key_name             = "my-devops-key"
# }

module "app-server" {
  source               = "./modules/ec2"
  count                = 1
  instance_type        = "t3.micro"
  instance_env         = "prod"
  instance_name        = "app-server"
  instance_role        = "application"
  subnet_id            = module.my_vpc.public_subnets_ids[0]
  security_groups_name = module.sg.sg_id
  ami_name_filter      = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  key_name             = "my-devops-key"
}

# module "monitoring-server" {
#   source               = "./modules/ec2"
#   count                = 1
#   instance_type        = "t3.small"
#   instance_env         = "prod"
#   instance_name        = "monitoring-server"
#   instance_role        = "monitoring"
#   subnet_id            = module.my_vpc.public_subnets_ids[0]
#   security_groups_name = module.sg.sg_id
#   ami_name_filter      = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
# }