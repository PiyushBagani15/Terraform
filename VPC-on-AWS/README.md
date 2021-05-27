# VPC infrastructure on AWS using Terraform
## Steps Performed:
1. Creating a VPC (Virtual Private Cloud in AWS).
2. Creating Public Subnets with auto public IP Assignment enabled.
3. Creating an Internet Gateway for Instances in the public subnet to access the Internet.
4. Creating a routing table, Here we will route our destination form anywhere in the world (0.0.0.0/0).
5. Associating the routing table to the Public Subnet
