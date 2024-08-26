resource "aws_eip" "eip_for_nat_gateway_az1" {
    tags = {
      Name = "nat gateway az1 eip"
    }
}

resource "aws_eip" "eip_for_nat_gateway_az2" {
    tags = {
      Name = "nat gateway az2 eip"
    }
}

resource "aws_nat_gateway" "nat_gateway_az1" {
    subnet_id = aws_subnet.public_subnet_az1.id
    allocation_id = aws_eip.eip_for_nat_gateway_az1.id
    
    # This will tell Terraform that the NAT gateway needs to be deleted first before the internet gateway is deleted
    depends_on = [aws_internet_gateway.internet_gateway]

    tags = {
        Name = "nat gateway az1"
    }
}

resource "aws_nat_gateway" "nat_gateway_az2" {
    subnet_id = aws_subnet.public_subnet_az2.id
    allocation_id = aws_eip.eip_for_nat_gateway_az2.id
    
    # This will tell Terraform that the NAT gateway needs to be deleted first before the internet gateway is deleted
    depends_on = [aws_internet_gateway.internet_gateway]

    tags = {
        Name = "nat gateway az2"
    }
}

resource "aws_route_table" "private_route_table_az1" {
    vpc_id  = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
    }

    tags = {
        Name = "private route table az1"
    }
}

resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
    subnet_id = aws_subnet.private_app_subnet_az1.id
    route_table_id = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table_association" "private_data_subnet_az1_route_table_az1_association" {
    subnet_id = aws_subnet.private_data_subnet_az1.id
    route_table_id = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table" "private_route_table_az2" {
    vpc_id  = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
    }

    tags = {
        Name = "private route table az2"
    }
}

resource "aws_route_table_association" "private_app_subnet_az2_route_table_az2_association" {
    subnet_id       = aws_subnet.private_app_subnet_az2.id
    route_table_id  = aws_route_table.private_route_table_az2.id
}

resource "aws_route_table_association" "private_data_subnet_az2_route_table_az2_association" {
    subnet_id       = aws_subnet.private_data_subnet_az2.id
    route_table_id  = aws_route_table.private_route_table_az2.id
}