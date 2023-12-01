env          = "prod"
project_name = "roboshop"
kms_key_id   = "arn:aws:kms:us-east-1:492681564023:key/e0d7eb6d-885f-412f-b2b6-3352d09b052a"
workstation_node_cidr = [ "172.31.23.171/32" ]
prometheus_cidr = [ "172.31.95.19/32"]

# VPC
vpc_cidr               = "10.20.0.0/16"
public_subnets         = ["10.20.0.0/24" , "10.20.1.0/24"]
web_subnets            = ["10.20.2.0/24" , "10.20.3.0/24"]
app_subnets            = ["10.20.4.0/24" , "10.20.5.0/24"]
db_subnets             = ["10.20.6.0/24" , "10.20.7.0/24"]
azs                    = ["us-east-1a" , "us-east-1b"]
account_no             = "492681564023"
default_vpc_id         = "vpc-0f69303a5ee298d49"
default_vpc_cidr       = "172.31.0.0/16"
default_route_table_id = "rtb-0cd5d19506508373c"

#RDS
rds_instance_class     = "db.t3.medium"

#DOCDB
docdb_instance_class   = "db.t3.medium"
docdb_instance_count   = 1

# Elastic_cache
ec_node_type = "cache.t3.micro"
ec_node_count = 1

# Rabbitmq
rabbitmq_instance_type = "t3.micro"

# Components

components = {
  frontend = {
    count = 2
    instance_type = "t3.micro"
    app_port = 80
    lb_type = "public"
    listener_rule_priority = 100
  }
  catalogue = {
    count = 2
    instance_type = "t3.micro"
    app_port = 8080
    lb_type = "private"
    listener_rule_priority = 100
  }
  cart = {
    count = 2
    instance_type = "t3.micro"
    app_port = 8080
    lb_type = "private"
    listener_rule_priority = 101
  }
  user = {
    count = 2
    instance_type = "t3.micro"
    app_port = 8080
    lb_type = "private"
    listener_rule_priority = 102
  }
  shipping = {
    count = 2
    instance_type = "t3.micro"
    app_port = 8080
    lb_type = "private"
    listener_rule_priority = 103
  }
  payment = {
    count = 2
    instance_type = "t3.micro"
    app_port = 8080
    lb_type = "private"
    listener_rule_priority = 104
  }
  dispatch = {
    count = 2
    instance_type = "t3.micro"
    app_port = 8080
    lb_type = "private"
    listener_rule_priority = 105
  }
}

# Load balancer
alb = {
  public = {
    internal = false
    port = 443
    protocol = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = "arn:aws:acm:us-east-1:492681564023:certificate/ea2dec62-a84a-40c8-a40d-ef3c8ce2e6de"
    alb_sg_allow_cidr = "0.0.0.0/0"
  }
  private = {
    internal = true
    port = 80
    protocol = "HTTP"
    ssl_policy        = null
    certificate_arn   = null
    alb_sg_allow_cidr = "10.20.0.0/16"
  }
}