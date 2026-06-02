terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0f2bbfa3fa9f61ba9"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-demo"
  }
}
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "ec2-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU使用率が80%を超えたらアラート"

  dimensions = {
    InstanceId = aws_instance.demo.id
  }
}