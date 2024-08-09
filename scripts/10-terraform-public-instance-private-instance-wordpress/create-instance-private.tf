# create-instance.tf
 
resource "aws_instance" "instance-private" {
  ami                         = var.instance_ami
#  availability_zone           = "${var.aws_region}${var.aws_region_az}"
  instance_type               = var.instance_type
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private.id]
  subnet_id                   = aws_subnet.subnet-private.id
  key_name                    = aws_key_pair.demo_key.key_name
  user_data                   = "${file(var.install_script_name_private_instance)}"
 
  tags = {
    "Owner"               = var.owner
    "Name"                = "${var.owner}-instance-private"
    "KeepInstanceRunning" = "false"
  }
}
