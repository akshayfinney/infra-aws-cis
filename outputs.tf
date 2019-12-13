# This script is to get the outputs after we execute main, dev_template and vars 
#output "instance_count" {
#  description = "List instance count"
#  value = "${aws_instance.testservice.instance_count}"
#}
output "id" {
  description = "List the ID of created instances"
  value = "${aws_instance.cisimage}"
}
output "arn" {
  description = "List the arn of the instance"  
  value = "${aws_instance.cisimage.arn}"
}
output "availability_zone" {
  description = "List availability zones"
  value = "${aws_instance.cisimage.availability_zone}"
}
output "public_dns" {
  description = "List Public DNS name"
  value = "${aws_instance.cisimage.public_dns}"
}
output "public_ip" {
  description = "List public IP of EC2 instance"
  value = "${aws_instance.cisimage.public_ip}"
}
output "private_ip" {
  description = "List the Private IP of the EC2 instance"
  value = "${aws_instance.cisimage.private_ip}"
}
output "tags" {
  description = "Listing all tags"
  value = "${aws_instance.cisimage.tags}"
}

output "vpc" {
  description = "Listing VPC ID"
  value = "${aws_vpc.cis_test.id}"
}



# Add support for VPC ID 
# Add support for output 


