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


