#for vpc
stage        = "dev-vllmhub"
vpc_cidr     = "10.0.0.0/8"
public_cidr  = "10.0.1.0/24"
private_cidr = "10.0.0.0/24"
credential = {
  domain_name = "OTC00000000001000101583"
  tenant_name = "eu-de"
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
}

#for ecs
key_name          = "my-key"
key_file          = "~/.ssh/id_rsa.pub"
#key_pvt_file      = "~/.ssh/id_rsa"
ssh_port          = 22
access_constraint = "0.0.0.0/0"
image_name = "Standard_Ubuntu_20.04_latest"
#image_name        = "Standard_Ubuntu_20.04_GPU_latest"
flavor_id     = "s3.medium.1"
#flavor_id = "p3.2xlarge.8"
