provider "aws" {
  region  = "us-east-1"
  version = "~> 2.61.0"
}

resource "aws_instance" "web" {
  ami             = "ami-0aa7d40eeae50c9a9"
  instance_type   = "t2.micro"   // costs $10 / month
  key_name        = "atunje-mbp" //name of ssh key
  security_groups = [aws_security_group.web.name]
  tags = {
    name = "WebServerByTf"
  }
}

resource "aws_security_group" "web" {
  name        = "web-security-group"
  description = "Allow access to our web server"

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // allow connections from anywhere
  }
}

output "instance_public_dns" {
  value = aws_instance.web.public_dns
}