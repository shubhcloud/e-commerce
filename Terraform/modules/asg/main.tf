resource "aws_launch_template" "cbc-lt" {
  name                   = var.lt_name
  instance_type          = var.instance_type
  image_id               = var.ami
  key_name               = var.key_name
  vpc_security_group_ids = [ var.vpc_security_group_ids ]
}

resource "aws_autoscaling_group" "cbc-asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = slice(data.aws_subnets.default.ids,0,2)
  default_instance_warmup   = 60

  launch_template {
    id      = aws_launch_template.cbc-lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "scale-out" {
  depends_on = [ aws_autoscaling_group.cbc-asg ]
  name                   = "cbc-scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale-in" {
  depends_on = [ aws_autoscaling_group.cbc-asg ]
  name                   = "cbc-scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = var.asg_name
}