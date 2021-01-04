module "vpc" {
  source = "./vpc"

  cidr_vpc            = var.cidr_vpc
  cidr_public_subnet  = var.cidr_public_subnet

}

module "testnet" {
  source            = "./testnet"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id

}

#module "mainnet" {
#  source            = "./mainnet"
#  vpc_id            = module.vpc.vpc_id
#  public_subnet_id  = module.vpc.public_subnet_id
#}
