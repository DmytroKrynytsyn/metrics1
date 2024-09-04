provider "aws" {
  region = var.aws_region  
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    self        = true
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "scrape"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    self        = true
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    self        = true
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "metrics"
    Purpose = "dkedu"
    Stack = "metrics1"
  }
}

resource "aws_instance" "prometheus" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "prometheus"
    Role = "prometheus"
    Purpose = "dkedu"
    Stack = "metrics1"
  }
}

resource "aws_instance" "grafana" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "grafana"
    Role = "grafana"
    Purpose = "dkedu"
    Stack = "metrics1"
  }
}

resource "aws_instance" "node" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "node"
    Role = "node"
    Purpose = "dkedu"
    Stack = "metrics1"
  }
}