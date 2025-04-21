resource "aws_cloudwatch_metric_alarm" "cw-high-cpu" {
  alarm_name          = "${var.alarm_name}-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 40

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [var.scale_out]
}


resource "aws_cloudwatch_metric_alarm" "cw-low-cpu" {
  alarm_name          = "${var.alarm_name}-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [var.scale_in]
}

