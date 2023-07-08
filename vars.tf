variable "SPOT_INSTANCE_COUNT" {}
variable "INSTANCE_TYPE" {}
variable "COMPONENT" {}
variable "ENV" {}
variable "VPC_ID" {}
variable "CIDR_BLOCK" {}
variable "WORKSTATION_IP" {}
variable "INSTANCE_COUNT" {}
variable "SUBNET_IDS" {}
variable "IAM_INSTANCE_PROFILE" {}
variable "PORT" {}
variable "IS_ALB_INTERNAL" {}
variable "CIDR_BLOCK_ELB_ACCESS" {}
variable "DBTYPE" {
  default = "null"
}
variable "DOCDB_ENDPOINT" {
  default = "null"
}
variable "PRIVATE_HOSTED_ZONE_ID" {}