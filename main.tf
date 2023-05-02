resource "aws_lb" "main" {
  name               = "${var.env}-${var.name}"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  enable_deletion_protection = var.enable_deletion_protection
  subnets  = var.subnets
  security_groups = [ aws_security_group.main.id]
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-${var.name}"
    }
  )
}

resource "aws_security_group" "main" {
  name        = "${var.name}-${var.env}-alb"
  description = "${var.name}-${var.env}-alb"
  vpc_id      = var.vpc_id

  ingress {
    description      = "APP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.allow_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-${var.env}-alb"
    },
  )
}



#Listener

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>503 - Invalid Response</h1>"
      status_code  = "503"
    }
  }
}


