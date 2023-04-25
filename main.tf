resource "aws_lb" "main" {
  name               = "${var.env}-${var.name}"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  enable_deletion_protection = var.enable_deletion_protection
  subnets  = var.subnets
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-${var.name}"
    }
  )
}
