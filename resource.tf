# This script will deploy a hardened image for ubuntu on AWS 
resource "aws_instance" "cisimage" {
    ami         = "${data.aws_ami.ubuntu.id}"
    # Update as per required cluster size
    # For sizing chart check here: https://aws.amazon.com/ec2/instance-types/c5/
    instance_type = "c5.4xlarge"	
    key_name = "${aws_key_pair.devops.id}"

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
  size = 500
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

# Adding Raphael's key pair for now 
# In the future deploy we'll need to pull this from a bucket in vars
resource "aws_key_pair" "devops" {
    key_name = "raphael"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU121RnVnHieJFK8xpviltjeup7ZS/bRy74CLm78078PiVuxthm/ZyJ7FOwyDqmlQOLtwXAxvn45JtQAap6mxdT0uBl/IfvhP2ZkAcKlFatpzeOoYAr2wneCuZCDO9EPWumgCDfsFrMbK78zaxX7I6V2KhYBR+1pEvFEx9IjsTFIUW7h87gihb7tA2jNWYdjeztIBe4YssBx9dNnQJWiaX6eGxk+lVCCkgxB7wgfCpD39js+k9U+nxquBIZ8CehqNNnWXJCNRSiqVFiQJI3auwZc7S7JHBpY9eKJ7sA5lTAByMfNeKaK5JRirVmJCr5xgnYb7O5LB0w37SYZCcH/GN rtheberge@Raphaels-MacBook-Pro.local"

}
