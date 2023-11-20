env          = "dev"
project_name = "roboshop"
kms_key_id   = "arn:aws:kms:us-east-1:492681564023:key/e0d7eb6d-885f-412f-b2b6-3352d09b052a"

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
docdb_instance_class   = "db.r5.large"
docdb_instance_count   = "1"