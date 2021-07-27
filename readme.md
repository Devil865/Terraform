#Create an resource vpc through terraform

Provider    =   aws
Region  =   
Resource    =   vpc
Cidr Range  =   10.1.0.0/16

#create an Subnets

pubsubnet   =   
prisubnet   =   
datasubnet  =   

create an igw and attch
cretae an eip
create a NAT and associate with pubsubnet

create 2 routetables
pubroutetable
priroutetable

associate the pubsubnet with igw
associate the pubsubnet with nat


terraform init
terraform plan
terraform apply

# Terraform
