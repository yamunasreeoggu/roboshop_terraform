env          = "dev"
project_name = "roboshop"
kms_key_id   = "arn:aws:kms:us-east-1:492681564023:key/e0d7eb6d-885f-412f-b2b6-3352d09b052a"
workstation_node_cidr = [ "172.31.23.171/32" ]
prometheus_cidr = [ "172.31.95.19/32"]

# VPC
vpc_cidr               = "10.0.0.0/16"
public_subnets         = ["10.0.0.0/24" , "10.0.1.0/24"]
web_subnets            = ["10.0.2.0/24" , "10.0.3.0/24"]
app_subnets            = ["10.0.4.0/24" , "10.0.5.0/24"]
db_subnets             = ["10.0.6.0/24" , "10.0.7.0/24"]
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
ec_node_count = 2

# Rabbitmq
rabbitmq_instance_type = "t3.micro"

# Components

components = {
  frontend = {
    count = 1
    instance_type = "t3.micro"
    app_port = 80
  }
  catalogue = {
    count = 1
    instance_type = "t3.micro"
    app_port = 8080
  }
  cart = {
    count = 1
    instance_type = "t3.micro"
    app_port = 8080
  }
  user = {
    count = 1
    instance_type = "t3.micro"
    app_port = 8080
  }
  shipping = {
    count = 1
    instance_type = "t3.micro"
    app_port = 8080
  }
  payment = {
    count = 1
    instance_type = "t3.micro"
    app_port = 8080
  }
  dispatch = {
    count = 1
    instance_type = "t3.micro"
    app_port = 8080
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
  }
  private = {
    internal = true
    port = 80
    protocol = "HTTP"
    ssl_policy        = null
    certificate_arn   = null
  }
}