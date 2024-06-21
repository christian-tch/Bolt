module "vpc" {
  source = "./modules/vpc"

  resource_prefix = "Bolt"
  vpc_cidr_block  = "192.168.0.0/16"
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_a_id
}