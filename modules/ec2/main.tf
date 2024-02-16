data "aws_ami" "selected_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_instance" "ec2" {
  ami             = data.aws_ami.selected_ami.id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.security_groups_name]
  key_name        = var.key_name

  tags = {
    Name = var.instance_name
    Role = var.instance_role
    Env  = var.instance_env
  }
}
