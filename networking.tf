# Setting up VPC 
resource "aws_vpc" "cis_test" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "cis-ubuntu"
    }
  
}
# Adding an EIP for this instance 
resource "aws_eip" "ip-cis" {
    instance = "${aws_instance.cisimage.id}"
    vpc = true
  
}

# Setting up subnets 
# If you have questions for cidr subnetting visit : http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/ 
resource "aws_subnet" "subnet1" {
    cidr_block = "${cidrsubnet(aws_vpc.cis_test.cidr_block,3,1)}"
    vpc_id = "${aws_vpc.cis_test.id}"
    availability_zone = "${var.availability_zone1.id}"  
    
}

# Setting up security groups to make this private 
# FYI even though aws by default allows all traffic outside, this is disabled by terraform and we need to explicitly state this
resource "aws_security_group" "ingress-all" {
    name = "allow-all-sg"

    vpc_id = "${aws_vpc.cis_test.id}"

    ingress {
        # Using Vancouver Office for now. Will need to add VPN route later
        cidr_blocks = ["207.81.212.51/32"]

        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
  # Adding egress to the internet, else we wouldnt have internet access 
    egress {
        from_port = 0
        to_port = 0 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Setting up an Internet Gateway
resource "aws_internet_gateway" "cis-gw" {
    vpc_id = "${aws_vpc.cis_test.id}"

    tags = {
        Name = "CIS-Gw"
    }
}

# Setup Route table
resource "aws_route_table" "cis-route" {
    vpc_id = "${aws_vpc.cis_test.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.cis-gw.id}"
    }

    tags = {
        Name = "cis-route-table"
    }
  
}

# Setup route table association
# Next we create an association between the subnet and the route table we just created which will expose the subnet to the internet allowing us access.
resource "aws_route_table_association" "subnet-association" {
    subnet_id = "${aws_subnet.subnet1.id}"
    route_table_id = "${aws_route_table.cis-route.id}"
  
}



