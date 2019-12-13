# Modify as needed for the environment
variable "environment" {
    default = "dev"
  
}
variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "availability_zone1" {
    description = "Avaialbility Zone for VPC"
    default = "us-west-2b"
}