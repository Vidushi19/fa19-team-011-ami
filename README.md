# fa19-team-011-ami

## Team Information

| Name | NEU ID | Email Address |
| Mrinal Rai| |001427584|Rai.mr@husky.neu.edu| 
| Vidushi Garg| |001417109|Garg.vid@husky.neu.edu| 
|Samartha Swaroop Girish|001401907|girish.s@husky.neu.edu| 

# Validate Template
packer validate centos.json
# Build AMI
packer build -var 'aws_region=us-east-1' centos.json
