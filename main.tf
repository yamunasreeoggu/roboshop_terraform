module "vpc" {
  source                 = "git::https://github.com/yamunasreeoggu/tf_module_vpc.git"
  vpc_cidr               = var.vpc_cidr
  env                    = var.env
  public_subnets         = var.public_subnets
  private_subnets        = var.web_subnets
  private_subnets        = var.app_subnets
  private_subnets        = var.db_subnets
  azs                    = var.azs
  account_no             = var.account_no
  default_vpc_id         = var.default_vpc_id
  default_vpc_cidr       = var.default_vpc_cidr
  default_route_table_id = var.default_route_table_id
}