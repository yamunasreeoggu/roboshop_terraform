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
  rds_instance_class = var.rds_instance_class
  kms_key_id = var.kms_key_id
}

module "docdb" {
  source    = "git::https://github.com/yamunasreeoggu/tf_module_docdb.git"
  component = "docdb"
  env       = var.env
  subnets   = module.vpc.db_subnets
  vpc_cidr  = var.vpc_cidr
  vpc_id    = module.vpc.vpc_id
  kms_key_id = var.kms_key_id
  docdb_instance_class = var.docdb_instance_class
  docdb_instance_count = var.docdb_instance_count
}

module "elasticache" {
  source    = "git::https://github.com/yamunasreeoggu/tf_module_elasticache.git"
  component = "elasticache"
  env       = var.env
  subnets   = module.vpc.db_subnets
  vpc_cidr  = var.vpc_cidr
  vpc_id    = module.vpc.vpc_id
  kms_key_id = var.kms_key_id
  ec_node_type  = var.ec_node_type
  ec_node_count = var.ec_node_count
}

module "rabbitmq" {
  source    = "git::https://github.com/yamunasreeoggu/tf_module_rabbitmq.git"
  component = "rabbitmq"
  env       = var.env
  subnets   = module.vpc.db_subnets
  vpc_cidr  = var.vpc_cidr
  vpc_id    = module.vpc.vpc_id
  kms_key_id = var.kms_key_id
  rabbitmq_instance_type = var.rabbitmq_instance_type
}

module "ms-components" {
  depends_on = [module.docdb, module.mysql, module.elasticache, module.rabbitmq]
  source    = "git::https://github.com/yamunasreeoggu/tf_module_app.git"

  for_each  = var.components
  component = each.key
  env       = var.env
  subnets   = module.vpc.db_subnets
  vpc_cidr  = var.vpc_cidr
  vpc_id    = module.vpc.vpc_id
  kms_key_id = var.kms_key_id
  instance_count = each.value["count"]
  prometheus_cidr = var.prometheus_cidr
  workstation_node_cidr = var.workstation_node_cidr
  instance_type = each.value["instance_type"]
  app_port = each.value["app_port"]
  alb_dns_name = lookup(lookup(module.alb, each.value["lb_type"], null), "alb_dns_name", null)
  zone_id = "Z10281701O26X6KFZM8G8"
  listener_arn = lookup(lookup(module.alb, each.value["lb_type"], null), "listener_arn", null)
  listener_rule_priority = each.value ["listener_rule_priority"]
}

module "alb" {
  source            = "git::https://github.com/yamunasreeoggu/tf_module_alb.git"
  for_each          = var.alb
  alb_sg_allow_cidr = each.value["alb_sg_allow_cidr"]
  alb_type          = each.key
  env               = var.env
  internal          = each.value["internal"]
  vpc_id            = module.vpc.vpc_id
  subnets           = each.key == "private" ? module.vpc.app_subnets : module.vpc.public_subnets
  port              = each.value["port"]
  protocol          = each.value["protocol"]
  ssl_policy        = each.value["ssl_policy"]
  certificate_arn   = each.value["certificate_arn"]
}


output "alb" {
  value = module.alb
}