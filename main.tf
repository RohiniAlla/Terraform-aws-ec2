data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]//hardware virtuvalization machine
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.nano"

  tags = {
    Name = "HelloWorld"
  }
}

data "aws_vpc" "default" {
  default = "true"
} //security group will taken as default security group

resource "aws_security_group" "blog" {
  name = "blog"
  description = "allow all traffic"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "blog_http_in" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog.id 
}
resource "aws_security_group_rule" "blog_http_out" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog.id
}

resource "aws_default_subnet" "usw1-az1" {
  availability_zone = "us-west-1b"
  tags = {
    Name = "Default subnet for us-west-1b"
  }
}





