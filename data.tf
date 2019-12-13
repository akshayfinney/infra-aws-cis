# This will set the data variable for aws_ami images 
data "aws_ami" "ubuntu" {
  most_recent = true

# Look for most recent ubuntu image with 18.04 Benchmark 
  filter {
    name   = "name"
    values = ["CIS Ubuntu Linux 18.04 LTS Benchmark v1.0.0.* - Level 1-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners =["679593333241"] # Owner set to CIS 
}