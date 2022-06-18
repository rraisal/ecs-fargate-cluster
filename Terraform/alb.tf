resource "aws_lb" "main" {
  name               = "${var.name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = false

  tags = {
    Name        = "${var.name}-alb-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "main" {
  name        = "${var.name}-tg-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.name}-tg-${var.environment}"
    Environment = var.environment
  }
}

#Redirect to https listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.main.id
        type             = "forward"
    }
}

# Redirect traffic to target group
# resource "aws_alb_listener" "https" {
#     load_balancer_arn = aws_lb.main.id
#     port              = 443
#     protocol          = "HTTPS"

#     ssl_policy        = "ELBSecurityPolicy-2016-08"
#     certificate_arn   = var.alb_tls_cert_arn

#     default_action {
#         target_group_arn = aws_alb_target_group.main.id
#         type             = "forward"
#     }
# }

output "aws_alb_target_group_arn" {
  value = aws_alb_target_group.main.arn
}

resource "aws_alb_listener" "ecs_alb_test_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_test_target_group.arn
  }
  depends_on = [aws_alb_target_group.ecs_test_target_group]
}

resource "aws_alb_target_group" "ecs_test_target_group" {
  name        = "ecstesttg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = "10"
    timeout             = "5"
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }
  tags = {
    Name = "${aws_ecs_cluster.main.name}-TestTG"
  }
  lifecycle {
    create_before_destroy = true
  }
}