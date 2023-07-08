locals {
  # Ids for multiple sets of EC2 instances, merged together
  ALL_INSTANCE_IDS = concat(aws_instance.instance.*.id, aws_spot_instance_request.spot.*.spot_instance_id)
}