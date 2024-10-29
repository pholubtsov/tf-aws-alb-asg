# Call the Providers module
module "providers" {
  source = "./modules/providers"
}

# Using state file from S3 bucket 
terraform {
  backend "s3" {
    profile = "admin"
    bucket         = "aws-tf-prjct-alb-asg"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

# Configure the AWS provider
provider "aws" {
  region  = var.region
  profile = "admin"
}

# Call the Security group module
module "aws-sg" {
  source                  = "./modules/aws-sg"
  alb_sg_name             = var.alb_sg_name
  launch_template_sg_name = var.launch_template_sg_name
  allowed_ip_http         = var.allowed_ip_http
  allowed_ip_ssh          = var.allowed_ip_ssh
}

# Call the Load balancer module
module "aws-alb" {
  source                = "./modules/aws-alb"
  vpc_id                = var.vpc_id
  alb_target_group_name = var.alb_target_group_name
  alb_name              = var.alb_name
  alb_security_groups   = module.aws-sg.alb_sg_id
  subnets               = var.subnets
}

# Call the Auto Scaling Group module
module "aws-asg" {
  source                  = "./modules/aws-asg"
  ami                     = var.ami
  asg_name                = var.asg_name
  launch_template_name    = var.launch_template_name
  launch_template_sg      = module.aws-sg.launch_template_sg_id
  instance_type           = var.instance_type
  target_group_arn        = module.aws-alb.alb_target_group_arn
  subnets                 = var.subnets
  topic_arn               = var.topic_arn
  ssh_key_name            = var.ssh_key_name
}