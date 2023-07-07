data "aws_ami" "ansible-ami" {
  most_recent      = true
  name_regex       = "base-ami-ansible"
  owners           = ["self"]
}