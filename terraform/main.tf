# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create Public Subnet
resource "aws_subnet" "my_public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project_name}-internet-gateway"
  }
}

# Create Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-route-table"
  }
}

# Associate Route Table
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# Create Security Group
resource "aws_security_group" "my_security_group" {
  name   = "my-security-group"
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project_name}-security-group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Server
resource "aws_instance" "my_server" {
  ami                    = "ami-060e277c0d4cce553"
  instance_type          = "t2.micro"

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  vpc_security_group_ids      = [aws_security_group.my_security_group.id]
  subnet_id                   = aws_subnet.my_public_subnet.id
  private_ip                  = "10.0.0.5"
  associate_public_ip_address = true
  key_name                    = "syafiqah-key"  # Update with your SSH key name

  tags = {
    Name = "${var.project_name}-server"
  }
}