resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.petclinic-dev.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-bastion-sg"
  }
}

#Key_Pair

resource "aws_key_pair" "petclinic" {
  key_name   = "petclinic-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD0JH1ABXN2SMDlUP2XE1Whv6wiHJoxJeh2QPphrEgFXWZ6eJDGS07Cjq361u+tK+pZByS2frOiY4rZicdcCQUvwlcblxZFQqONQ8dBrackGoo0bE/WT2YOVDRnYIfr4CpF/M3+z27qlfTjtBZ70m/GAGeVf6gnlgDGIXU8229a+w456j05j9jNEb+d3XOttVKak4t0n8/jvptbzWUFBUiWamLqx+wSnsL6z1/zz/6EyiYImjDZV+odG4zsRnQ4SJkCkXHzGd/Vl7oEh0HQwGWGjjzT+UZMjPhYfYexJ5yVoGS+lclfG9jQIoiHIbs99K4L1zvqyPVcnyGnPRQUb3+MzeOQ/EgDL1dHosIksEJtynlYarTJt8t+ODTEHx3i2pvzrQhbkYzN3o2dxJ6PDUkZpDlfUFkShVtWZbdZq2OuQr0IM96XCJFFCMv5CMmo6we7kgOuqNFQK8vhuyU/+rqshfGezxzmxrLY9pOF2pgbBtZDZljJZVDCyfEUnfGWA1E= Lenovo@DESKTOP-VG20LSH"
}
#Creating an Bastion ec2
resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.petclinic.id
  subnet_id = aws_subnet.pubsubnet[0].id
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  tags = {
    Name = "${var.envname}-bastion"
  }
}