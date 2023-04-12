# Configure the AWS Provider
provider "aws" {
    region  = "us-east-1"
    access_key = ""
    secret_key = ""

}
#VPC creation
resource "aws_vpc" "my_first_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "prod"
  }
}


#Subnet creation
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.my_first_vpc.id
  cidr_block = "10.0.0.16/28"

  tags = {
    Name = "prod-subnet"
  }
}

# Ec2 instance creation
resource "aws_instance" "my-first-server" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  tags = {
    Name = "ubuntu"
}
}
   

