resource "aws_lb" "web_app_alb" {
  name               = "${var.environment}-web-app-lt"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
    aws_subnet.public_subnet_3.id,
  ]

  tags = {
    Name        = "${var.environment}-WebApp-ALB"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "web_app_tg" {
  name     = "${var.environment}-web-app-tg"
  port     = var.webapp_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path                = "/healthz"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.web_app_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_app_tg.arn
#   }
# }

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.web_app_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.imported_ssl_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_app_tg.arn
  }
}
