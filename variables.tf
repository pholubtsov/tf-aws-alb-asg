# -------------------------- Common variables -------------------------- #
variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "tfstate_bucket_name" {
  type        = string
  description = "S3 bucket name for .tfstate file"
}


# -------------------------- Security groups module variables -------------------------- #
variable "alb_sg_name" {
  type        = string
  description = "Name of the security group fot ALB"
}

variable "launch_template_sg_name" {
  type        = string
  description = "Name of the security group for launch template"
}

variable "allowed_ip_http" {
  type        = string
  description = "CIDR block to allow HTTP access"
}

variable "allowed_ip_ssh" {
  type        = string
  description = "CIDR block to allow SSH access"
}



# -------------------------- ASG module variables -------------------------- #
variable "ami" {
  type        = string
  description = "AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
}

variable "asg_name" {
  type        = string
  description = "Name of the Auto-Scaling Group"
}

variable "launch_template_name" {
  description = "Launch template name"
  type        = string
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name to import"
}

variable "topic_arn" {
  type        = string
  description = "The arn of simple notification service topic"
}


# -------------------------- ALB module variables -------------------------- #
variable "vpc_id" {
  type        = string
  description = "VPC ID to use"
}

variable "alb_target_group_name" {
  type        = string
  description = "Name of the target group for ALB"
}

variable "alb_name" {
  type        = string
  description = "Name of the ALB"
}
