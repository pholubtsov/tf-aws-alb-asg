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
  description = "CIDR block allowed for HTTP access"
}

variable "allowed_ip_ssh" {
  type        = string
  description = "CIDR block to allow SSH access"
}