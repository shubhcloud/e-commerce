module "provisioner" {
  source = "./modules/provisioner"
  region = var.region
}

module "asg" {
  source = "./modules/asg"
  lt_name                = var.lt_name
  instance_type          = var.instance_type
  ami                    = var.ami
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  asg_name               = var.asg_name
  max_size               = var.max_size
  min_size               = var.max_size
  desired_capacity       = var.desired_capacity
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  alarm_name = var.alarm_name
  asg_name   = module.asg.asg_name
  scale_in   = module.asg.scale-in
  scale_out  = module.asg.scale-out
}