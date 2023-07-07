data "aws_ami" "ansible-ami" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "^base-ami-ansible"
  owners           = ["self"]
}