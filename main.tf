provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh_"

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "vm" {
  count         = 5
  ami           = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"
  key_name      = "jul-20-key"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "vm${count.index + 1}"
  }
}

resource "local_file" "hosts_file" {
  content  = <<EOF
10.0.0.1 vm1
10.0.0.2 vm2
10.0.0.3 vm3
10.0.0.4 vm4
10.0.0.5 vm5
EOF
  filename = "${path.module}/hosts"
}
