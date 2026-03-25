#Create two VPCs (ProdVpc AND Test Vpc)
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "vpc1" }
}

#Create VPC2
resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
  tags       = { Name = "vpc2" }
}

#Create subnets
#Create a public subnet for VPC1
resource "aws_subnet" "vpc1_public" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags                    = { Name = "vpc1_public" }
}

#Create a private vpc for vpc1
resource "aws_subnet" "vpc1_private" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-2b"
  tags                    = { Name = "vpc1_private" }

}

#Create a public_subnet for VPC2
resource "aws_subnet" "vpc2_public" {
  vpc_id                  = aws_vpc.vpc2.id
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true
  cidr_block              = "10.1.2.0/24"
  tags                    = { Name = "vpc2_public" }
}

#create internet gateway
resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id
  tags   = { Name = "vpc1-IGW" }
}

#Create internet gateway for vpc2
resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = aws_vpc.vpc2.id
  tags   = { Name = "VPC2_IGW" }
}

#Create the Route Table
resource "aws_route_table" "vpc1_public_rt" {
  vpc_id = aws_vpc.vpc1.id
  tags   = { Name = "VPC1_public-RT" }
}

#Provider the internet route to public subnet of VPC1, so that it can be accessed through the internet
resource "aws_route" "vpc1_public_internet" {
  route_table_id         = aws_route_table.vpc1_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1_igw.id
}

#Now associate the route table with the public subnet through aws_route_table_association
resource "aws_route_table_association" "vpc1_public_access" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

#create a route table for VPC1_private subnet
resource "aws_route_table" "vpc1_private_rt" {
  vpc_id = aws_vpc.vpc1.id
  tags   = { Name = "VPC1_private-RT" }
}

#Now associate the route table with the public subnet through aws_route_table_association
resource "aws_route_table_association" "vpc1_private_access" {
  subnet_id      = aws_subnet.vpc1_private.id
  route_table_id = aws_route_table.vpc1_private_rt.id
}

#now create a route_table for public_subnet of vpc2
resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2.id
  tags   = { Name = "VPC2_public_RT" }
}

#Provider the internet route to public subnet of VPC1, so that it can be accessed through the internet
resource "aws_route" "vpc2_public_internet" {
  route_table_id         = aws_route_table.vpc2_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc2_igw.id
}

#Now associate the route yable with the public subnet through aws_route_table_association
resource "aws_route_table_association" "vpc2_public_access" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

#Vpc_peering, so that both the VPC1 and VPC2 can be able to communicate with each other
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
  tags        = { Name = "VPC1-VPC2-peering" }

}

#add route in VPC1 private subnet to reach VPC2 via peering
resource "aws_route" "vpc1_private_to_vpc2" {
  route_table_id            = aws_route_table.vpc1_private_rt.id
  destination_cidr_block    = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

#Now also add a route in VPC2 public subnet to reach VPC(Public, private subnet) peering
resource "aws_route" "vpc2_public_to_vp1" {
  route_table_id            = aws_route_table.vpc2_public_rt.id
  destination_cidr_block    = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
