resource "aws_spot_instance_request" "spot" {
  count         = var.SPOT_INSTANCE_COUNT
  wait_for_fulfillment = true
  ami           = data.aws_ami.ansible-ami.id
  spot_type     = "persistent"
  instance_type = var.INSTANCE_TYPE
  subnet_id              = var.SUBNET_IDS[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

resource "aws_ec2_tag" "example" {
  count         = var.SPOT_INSTANCE_COUNT
  resource_id   = element(aws_spot_instance_request.spot.*.spot_instance_id, count.index+1)
  key           = "Name"
  value         = "${var.COMPONENT}-${var.ENV}"
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

resource "null_resource" "connect" {
  triggers = {
    ABC = timestamp()
  }
  count = length(local.ALL_INSTANCE_IDS)
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["SSH_USERNAME"]
      password = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["SSH_PASSWORD"]
      host     = element(local.ALL_INSTANCE_IDS,count.index)
    }
    inline = [
      "ansible-pull -U https://github.com/chandralekhasingasani/practice-ansible.git -e HOST=localhost -e ROLE_NAME=${var.COMPONENT} -e ENV=${var.ENV}"
    ]
  }
}


data "aws_secretsmanager_secret" "roboshop" {
arn = "arn:aws:secretsmanager:us-east-1:697140473466:secret:roboshop-3wTSpx"
}

data "aws_secretsmanager_secret_version" "roboshop" {
  secret_id = data.aws_secretsmanager_secret.roboshop.id
}
