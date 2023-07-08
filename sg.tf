resource "aws_security_group" "allow_tls" {
  name        = "allow_ssh"
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
    description = "Allow 8080"
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
    Name = "allow_tls"
  }
}