provider "aws" {
  region = var.region
  shared_credentials_files = var.shared_credentials_files
  profile = var.profile
}

resource "aws_instance" "web" {
  ami= var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  root_block_device {
    delete_on_termination = true
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.app_name}-vm-${terraform.workspace}"
    Environment = var.env
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.web_sg ]
}

resource "aws_security_group" "web_sg" {
  name        = "allow_3000"
  description = "Allow traffic on port 3000"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}