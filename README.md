# infra-aws-cis
CIS benchmarked image on AWS. 

This repo holds terraform scripts to deploy an ubuntu 18.04 image that satisfies the CIS benchmark for OS hardening. 

# What's different from standard deploys

In our standard deploys we typically pull the OS ubuntu 18.04 image owned by Canonical. However in this case, we are pulling the image hardened, reviewed, approved and owned by CIS themselves. 

NOTE: When running a ```terraform apply``` you may receive an error with the following:

``` Error:Error launching source instance: OptInRequired: In order to use this AWS Marketplace product you need to accept terms and subscribe. To do so please visit https://aws.amazon.com/marketplace/pp?sku=b1e35cepur7ecue1bq883thxr
      status code:401, request id: 143db6ff-46be-40990a4bg-fe41949282bd 
``` 
      
This is because we would have to pay for this image via the MPA account. 

# Warning!

These scripts don't actually satisfy the entire suite of CIS related security controls but this is just the image in iteslf. 
