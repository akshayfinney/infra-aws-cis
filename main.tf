# This script is for us to deploy a hardened ubuntu image into aws 
# NOTE: This script will need to be updated as newer images are released 
# NOTE: Make sure to also pick the right region while deploying 
provider "aws" {
  region = "us-west-2"
  shared_credentials_file = "~/.aws/credentials"
  
  #rename this profile based on what you call your profile under ~/.aws/creds 
  profile = "mfa"
  assume_role {
    role_arn = "arn:aws:iam::367805628163:role/TIQ_Admin"
  }
  
}
