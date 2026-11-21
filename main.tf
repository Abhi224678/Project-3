provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "monitoring" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.default.ids[0]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y stress-ng
    stress-ng --cpu 2 --timeout 900s --metrics-brief
  EOF

  tags = {
    Name = "Project-3-CloudWatch-EC2"
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "Project-3-High-CPU-Terraform"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm when EC2 CPU utilization exceeds 70 percent"

  dimensions = {
    InstanceId = aws_instance.monitoring.id
  }

  treat_missing_data = "notBreaching"
}

output "instance_id" {
  value = aws_instance.monitoring.id
}

output "public_ip" {
  value = aws_instance.monitoring.public_ip
}

output "cloudwatch_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}
