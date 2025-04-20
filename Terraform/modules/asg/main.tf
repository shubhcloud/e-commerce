resource "aws_launch_template" "e-commerce-lt" {
  name                   = var.lt_name
  instance_type          = var.instance_type
  image_id               = var.ami
  key_name               = var.key_name
  vpc_security_group_ids = [ var.vpc_security_group_ids ]
  
   user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Hello from $(hostname)" > /var/www/html/index.html
              EOF
}

resource "asg" "e-commerce-asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

  launch_template {
    id      = aws_launch_template.id
    version = "$Latest"
  }
}

