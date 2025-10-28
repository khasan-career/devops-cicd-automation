variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group for the ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets for the ALB"
  type        = list(string)
}

variable "instance_id" {
  description = "EC2 instance ID to attach to target group"
  type        = string
}

# ---------------------------------------
# Create ALB
# ---------------------------------------
resource "aws_lb" "this" {
  name               = "project1-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "project1-alb"
  }
}

# ---------------------------------------
# Target Group
# ---------------------------------------
resource "aws_lb_target_group" "web_tg" {
  name     = "project1-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "project1-web-tg"
  }
}

# ---------------------------------------
# Listener
# ---------------------------------------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# ---------------------------------------
# Target Group Attachment
# ---------------------------------------
resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = var.instance_id
  port             = 80
}

# ---------------------------------------
# Outputs
# ---------------------------------------
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}
