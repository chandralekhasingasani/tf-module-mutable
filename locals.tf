locals {
  # Ids for multiple sets of EC2 instances, merged together
  ALL_INSTANCE_IDS = concat(aws_instance.instance.*.id, aws_spot_instance_request.spot.*.spot_instance_id)
  ALL_INSTANCE_IPS = concat(aws_instance.instance.*.private_ip, aws_spot_instance_request.spot.*.private_ip)
}