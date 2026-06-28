provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "hard_ware_sg" {
  name = "hard_ware_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "hard_ware_vm" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type = "t3.micro"
  key_name      = var.key_name

  security_groups = [aws_security_group.hard_ware_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "hard_ware_vm"
  }
}

output "public_ip" {
  value = aws_instance.hard_ware_vm.public_ip
}