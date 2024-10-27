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

variable "alb_security_groups" {
  type        = string
  description = "ID of the security group"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs for the Application Load Balancer"
}