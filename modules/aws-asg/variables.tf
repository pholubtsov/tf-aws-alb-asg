variable "launch_template_name" {
  description = "Launch template name prefix"
  type        = string
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name to import"
}

variable "ami" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the instances"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "launch_template_sg" {
  type        = string
  description = "ID of the security group"
}

variable "target_group_arn" {
  type        = string
  description = "The arn of targed group to attach"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "topic_arn" {
  type        = string
  description = "The arn of simple notification service topic"
}