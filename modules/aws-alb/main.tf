# Target group configuration
resource "aws_lb_target_group" "alb_target_group" {
  name     = var.alb_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Load Balancer Configuration
resource "aws_lb" "app_load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets

  security_groups    = [var.alb_security_groups]
}

# Listener for the ALB
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

# Outputs
output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}
