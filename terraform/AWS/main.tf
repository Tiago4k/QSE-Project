provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "es-stormcrawler-ssh-http" {
  name        = "es-stormcrawler-ssh-http"
  description = "Allows ssh and http traffic on ports 22, 9200, 5601"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "es-stormcrawler-terra" {
  ami             = "ami-03ef731cc103c9f09"
  instance_type   = "t2.medium"
  security_groups = ["${aws_security_group.es-stormcrawler-ssh-http.name}"]
  key_name        = "stormcrawler-terraform"
  user_data       = "${file("minimal_install.sh")}"

  tags = {
    name = "server"
  }
}
