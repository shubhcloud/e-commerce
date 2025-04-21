output "asg_name" {
  value = aws_autoscaling_group.cbc-asg.name
}

output "scale-out" {
  value = aws_autoscaling_policy.scale-out.arn
}

output "scale-in" {
  value = aws_autoscaling_policy.scale-in.arn
}