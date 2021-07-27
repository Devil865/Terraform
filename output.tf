output "petclinicname"{
    value = aws_vpc.petclinic-dev.id
    #value = aws_vpc.petclinic.cidr_block
}