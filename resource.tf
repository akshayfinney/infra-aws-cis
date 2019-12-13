# This script will deploy a hardened image for ubuntu on AWS 
resource "aws_instance" "cisimage" {
    ami         = "${data.aws_ami.ubuntu.id}"
    # Update as per required cluster size
    # For sizing chart check here: https://aws.amazon.com/ec2/instance-types/c5/
    instance_type = "c5.4xlarge"	 
    #subnet_id   = "${aws_subnet.subnet0-dev.id}"
    #security_groups = ["${aws_security_group.testservice.id}"]
    #add additional ec2 instances as needed by manipulating the count var
    #count = 3
    tags = {
        Name = "cis_test"
        Terraform   = "true"
        Environment = "${var.environment}"
    }
  
}
# Creating EBS Storage storage and attaching it to EC2 instance 
resource "aws_ebs_volume" "ebs" {
  availability_zone = "${var.availability_zone1}"
  # EBS volume size. Usually in GiB. Set as per requirements. 
  size = 100
  # Encrypt the disk
  encrypted = true
}

resource "aws_volume_attachment" "ebs_attach" {
  # Creating primary partition /dev/sda1 
  device_name = "/dev/sda"
  # Get volume ID 
  volume_id = "${aws_ebs_volume.ebs.id}"
  # Get instance ID 
  instance_id = "${aws_instance.cisimage.id}"
  
}
