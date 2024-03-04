# create-instance.tf
 
resource "aws_instance" "instance-public" {
  ami                         = var.instance_ami
#  availability_zone           = "${var.aws_region}${var.aws_region_az}"
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = aws_subnet.subnet-public.id
  key_name                    = aws_key_pair.demo_key.key_name
  user_data                   = "${file(var.install_script_name_public_instance)}"
 
 
  tags = {
    "Owner"               = var.owner
    "Name"                = "${var.owner}-instance-public"
    "KeepInstanceRunning" = "false"
  }
}
