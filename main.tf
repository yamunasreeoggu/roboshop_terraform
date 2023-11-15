variable "components" {
  default = [
    "frontend", # comma is needed as we have next entries
    "catalogue",
    "user",
    "cart",
    "shipping",
    "payment",
    "dispatch",
    "mongodb",
    "mysql",
    "rabbitmq",
    "redis"
  ]
}

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

resource "aws_instance" "instance" {
  count                  = length(var.components) #this resource creation will repeat those many times we declared components in variables
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-0a9fe6f055e22e092"] #allow-all sg ID from aws
  tags = {
    Name = element(var.components, count.index) #name to instance will be given with the help of var.component and it will repeat those many times we declared components in variables using count.index
  }
}

resource "aws_route53_record" "dns-record" {
  count   = length(var.components)
  zone_id = "Z10281701O26X6KFZM8G8" #from aws route53 record hosted zonde ID
  name    = "${element(var.components, count.index)}-dev" #record will be created as "name-dev"
  type    = "A"
  ttl     = 10
  records = [element(aws_instance.instance.*.private_ip, count.index)] # records will be created using private IP
}

resource "null_resource" "set-hostname" { # required to set hostname to instances
  count   = length(var.components)
  provisioner "remote-exec" {
    connection {
      host = element(aws_instance.instance.*.private_ip, count.index)
      user = "root"
      password = "DevOps321"
    }
    inline = [
      "set-hostname -skip-apply ${var.components[count.index]}"
    ]
  }
}
