#creating vpc 
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = "vpc-tf"
  }

}
#Creating the Internet Gateway and attaching it to VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myigw"
  }
}
#Creating Public Subnets(dynamically) where all the instances launched inside this subnet, will automatically be provided a public IP from which they will connect to the Internet Gateway.
resource "aws_subnet" "main" {
  count = length(var.subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element( var.subnets_cidr,  count.index  )
  availability_zone = element( var.azs , count.index )
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

#creating routing table as by default there is local connectivity, hence Here we will route our destination form anywhere in the world (0.0.0.0/0).
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

#associating route table with subnets
resource "aws_route_table_association" "tf-route" {
  count = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.example.id
}
#Now to automatically build our VPC, execute the terraform apply command.