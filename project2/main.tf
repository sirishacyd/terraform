# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  access_key = ""
  secret_key = ""
}

# 1. Create a VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

#2. Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod_vpc.id
}

#3. Create a custom route table
resource "aws_route_table" "prod_route_table" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod"
  }
}

#4. Create a subnet
resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}

#5. Associate the subnet with the route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.prod_route_table.id
}

#6. Create a security group to allow ports 22, 80, and 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

#7. Create a network interface with an IP in the subnet created in step 4
resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.subnet_1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

#8. Assign an Elastic IP to the network interface created in step 7
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web_server_nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.gw]
}

#9. Create an Ubuntu server and install/enable Apache2
resource "aws_instance" "web_server_instance" {
  ami           = ""
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = ""
  
  network_interface {
    network_interface_id = aws_network_interface.web_server_nic.id
    device_index         = 0
  }
  
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install apache2 -y
              systemctl enable apache2
              systemctl start apache2
              sudo bash -c 'echo "<h1>First Web Server</h1>" > /var/www/html/index.html'
              EOF

  tags = {
    Name = "web-server"
  }
}

       



  
