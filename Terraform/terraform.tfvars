region = "ap-south-1"
lt_name = "cbc-lt"
instance_type = "t2.micro"
ami = "ami-0e35ddab05955cf57"
key_name = "kubeadm"
vpc_security_group_ids = "sg-081d326dcaffd513f"
asg_name = "cbc-asg"
max_size = "5"
min_size = "1"
desired_capacity = "1"
alarm_name = "cbc-alarm"