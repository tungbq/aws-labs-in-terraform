resource "aws_instance" "web" {
  ami                    = "ami-0c94855ba95c71c99"     # choose the AMI for your desired OS
  instance_type          = "t2.micro"                  # choose the instance type that meets your needs
  subnet_id              = aws_subnet.my_subnet.id     # use the subnet that you created in the previous step
  vpc_security_group_ids = [aws_security_group.web.id] # specify the security group that allows HTTP traffic
  key_name               = "your-key-name"             # replace with your own key name
  user_data              = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF
}

resource "aws_security_group" "web" {
  name_prefix = "web"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
