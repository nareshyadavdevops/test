/*resource "aws_security_group" "example" {
  name        = "example"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "to test"
  }
}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  #ipv6_cidr_block = 


  tags = {
    Name = "main"
    Evnironment = "dev"
  }
}*/


resource "aws_autoscaling_policy" "test_policy" {
  name                   = "terraform-test_auto_sacla_policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "test"
}

resource "aws_cloudwatch_metric_alarm" "test" {
  alarm_name          = "terraform-test"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 10
  statistic           = "Maximum"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = "test_group"
    }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.test_policy.arn]
}


