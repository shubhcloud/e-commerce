resource "aws_cloudwatch_metric_alarm" "cw-high-cpu" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [var.scale_out]
}


resource "aws_cloudwatch_metric_alarm" "cw-low-cpu" {
  alarm_name          = var.alarm_name
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 40

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [var.scale_in]
}

