provider "aws" {
  region = "us-east-1" # Change as needed
}

resource "aws_instance" "web" {
  ami                    = "ami-04b4f1a9cf54c11d0" # Amazon Linux 2 (Update with latest)
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user_data.sh")

  tags = {
    Name = "WebServer-With-Monitoring"
  }
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}
