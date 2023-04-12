### project1

* Terraform init is the first command that should be run when setting up a new Terraform project or when working with an existing project for the first time on a new machine.

![init](screenshots/init.png)

* Terraform plan helpful step to preview the changes that will be made to your infrastructure before actually applying them. This allows you to review the changes and ensure they align with intentions.

![plan](screenshots/plan.png)

*  Terraform apply is used to create, update, or delete infrastructure resources.

![apply](screenshots/apply.png)

![apply1](screenshots/apply1.png)

* EC2 using terraform

![ec2](screenshots/ec2.png)

* Subnet using terraform

![subnet](screenshots/subnet.png)

* VPC using terraform

![vpc.png](screenshots/vpc.png)

* destroy 

![destroy](screenshots/destroy.png)

### project2

Steps: 

1.Configure the AWS Provider

2.Create a VPC

3.Create an internet gateway

4.Create a custom route table

5.Create a subnet

6.Associate the subnet with the route table

7.Create a security group to allow ports 22, 80, and 443

8.Create a network interface with an IP in the subnet created in step 4

9.Assign an Elastic IP to the network interface created in step 7

10.Create an Ubuntu server and install/enable Apache2


![apply](screenshots/3.png)

VPC:

![vpc](screenshots/1.png)

Subnet:

![subnet](screenshots/2.png)

EC2:

![ec2](screenshots/5.png)

SSH login:


![server](screenshots/6.png)

server: 


![http](screenshots/7.png)

Destroy:


![destroy](screenshots/8.png)

![destroy](screenshots/9.png)






