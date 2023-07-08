resource "aws_lb_target_group" "test" {
  name     = "${var.COMPONENT}-${var.ENV}-tg"
  port     = var.PORT
  protocol = "HTTP"
  vpc_id   = var.VPC_ID
  health_check {
    healthy_threshold = 3
    enabled = true
    interval = 10
    path = "/health"
    port = var.PORT
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "test" {
  count = length(local.ALL_INSTANCE_IDS)
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = element(local.ALL_INSTANCE_IDS,count.index)
  port             = var.PORT
}

resource "aws_lb" "test" {
  name               = "${var.COMPONENT}-${var.ENV}-alb"
  internal           = var.IS_ALB_INTERNAL
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_alb.id]
  subnets            = var.SUBNET_IDS
  tags = {
    Environment = "${var.COMPONENT}-${var.ENV}-alb"
  }
}

resource "aws_lb_listener" "component" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}