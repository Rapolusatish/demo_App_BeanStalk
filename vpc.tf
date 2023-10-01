resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"  # Subnet A CIDR block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.2.0/24"  # Subnet B CIDR block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

# Associate the route table with the subnets
resource "aws_route_table_association" "subnet_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.example.id
  
}

resource "aws_route_table_association" "subnet_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.example.id
}

# Rest of your resources (Elastic Beanstalk, ELB, ASG, etc.) go here...
