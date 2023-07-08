resource "aws_security_group" "allow_tls" {
  name        = "allow_ssh_${var.ENV}-${var.COMPONENT}"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.CIDR_BLOCK,var.WORKSTATION_IP]
  }

  ingress {
    description = "APP"
    from_port   = var.PORT
    to_port     = var.PORT
    protocol    = "tcp"
    cidr_blocks = [var.CIDR_BLOCK]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_${var.ENV}-${var.COMPONENT}"
  }
}


resource "aws_security_group" "allow_alb" {
  name        = "allow_alb_${var.ENV}-${var.COMPONENT}"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.CIDR_BLOCK_ELB_ACCESS
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.CIDR_BLOCK_ELB_ACCESS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_alb_${var.ENV}-${var.COMPONENT}"
  }
}