resource "aws_spot_instance_request" "spot" {
  count         = var.SPOT_INSTANCE_COUNT
  wait_for_fulfillment = true
  ami           = data.aws_ami.ansible-ami.name
  spot_type     = "persistent"
  instance_type = var.INSTANCE_TYPE
  subnet_id              = var.SUBNET_IDS[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

resource "aws_instance" "instance" {
  count         = var.INSTANCE_COUNT
  ami           = data.aws_ami.ansible-ami.id
  instance_type = var.INSTANCE_TYPE
  subnet_id              = var.SUBNET_IDS[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}