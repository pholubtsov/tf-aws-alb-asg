# Launch Template Configuration
resource "aws_launch_template" "app_launch_template" {
  name          = var.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type
  key_name = var.ssh_key_name
  vpc_security_group_ids = [var.launch_template_sg]

  user_data = filebase64("./modules/aws-asg/change-index-html.sh")
}

# Auto Scaling Group Configuration
resource "aws_autoscaling_group" "app_asg" {
  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }

  name                      = var.asg_name
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"

  target_group_arns = [var.target_group_arn]

  vpc_zone_identifier = var.subnets
}

# Notifications Configuration
resource "aws_autoscaling_notification" "app_asg_notifications" {
  group_names   = [aws_autoscaling_group.app_asg.name]
  topic_arn     = var.topic_arn
  notifications = ["autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE"]
}

# Scheduled Scaling Actions
resource "aws_autoscaling_schedule" "scale_out" {
  scheduled_action_name  = "Scale-Out"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  desired_capacity       = 2
  min_size               = 1
  max_size               = 2
  #recurrence             = "*/2 * * * *"  # Every 2 minutes
  start_time             = "2024-10-27T21:09:00Z"
}

resource "aws_autoscaling_schedule" "scale_in" {
  scheduled_action_name  = "Scale-In"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  desired_capacity       = 1
  min_size               = 1
  max_size               = 2
  #recurrence             = "*/3 * * * *"  # Every 3 minutes
  start_time             = "2024-10-27T21:11:00Z"
}