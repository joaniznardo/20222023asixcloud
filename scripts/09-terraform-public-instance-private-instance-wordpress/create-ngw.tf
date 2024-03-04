resource "aws_eip" "nat_eip" {
  vpc = true
 
  lifecycle {
    # prevent_destroy = true
  }

  
  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-rt-private"
  }

  
}

resource "aws_nat_gateway" "ngw" {

  allocation_id = aws_eip.nat_eip.id
 
  #subnet_id = aws_subnet.public[element(keys(aws_subnet.public), 0)].id
  #subnet_id = aws_subnet.subnet-private.id
  subnet_id = aws_subnet.subnet-public.id

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-rt-private"
  }

}


