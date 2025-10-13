## main.tf - root module wiring. Calls modules/* and passes variables/outputs between modules.
resource "aws_lb" "app" {
  name               = "ci-cd-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [var.sg_id]
}

resource "aws_lb_target_group" "tg" {
  name     = "ci-cd-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.target_instance_id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

output "alb_dns_name" { value = aws_lb.app.dns_name }
