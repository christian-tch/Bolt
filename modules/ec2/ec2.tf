module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = "Bolt-EC2"
  ami = "ami-0551ce4d67096d606"
  associate_public_ip_address = true
  availability_zone = "eu-west-1a"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [module.instance_sg.security_group_id]
  user_data       = local.user_data
  user_data_replace_on_change = true
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }
}

module "instance_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "Bolt-instance-sg"
  description = "instance security group"
  vpc_id      = var.vpc_id

  computed_ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  number_of_computed_ingress_with_cidr_blocks = 1

  egress_rules = ["all-all"]
}