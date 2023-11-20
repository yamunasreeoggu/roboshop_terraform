module "vpc" {
  source                 = "git::https://github.com/yamunasreeoggu/tf_module_vpc.git"
  vpc_cidr               = var.vpc_cidr
  env                    = var.env
  public_subnets         = var.public_subnets
  web_subnets            = var.web_subnets
  app_subnets            = var.app_subnets
  db_subnets             = var.db_subnets
  azs                    = var.azs
  account_no             = var.account_no
  default_vpc_id         = var.default_vpc_id
  default_vpc_cidr       = var.default_vpc_cidr
  default_route_table_id = var.default_route_table_id
}

module "mysql" {
  source    = "git::https://github.com/yamunasreeoggu/tf_module_rds.git"
  component = "mysql"
  env       = var.env
  subnets   = module.vpc.db_subnets
  vpc_cidr  = var.vpc_cidr
  vpc_id    = module.vpc.vpc_id
  instance_class = var.instance_class
  kms_key_id = var.kms_key_id
}
