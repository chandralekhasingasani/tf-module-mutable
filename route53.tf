data "aws_route53_zone" "selected" {
  name         = "roboshop.internal"
  private_zone = true
}

resource "aws_route53_zone_association" "secondary" {
  zone_id = data.aws_route53_zone.selected.id
  vpc_id  = var.VPC_ID
}

resource "aws_route53_record" "component" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "${var.COMPONENT}-${var.ENV}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.test.arn]
}