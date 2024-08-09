# create-key-pair.tf
 
# resource "aws_key_pair" "keypair" {
#    #key_name    = "TerraformAnsible-Keypair"
#    key_name    = var.key_pair
#    #public_key  = "joc-key-pair.pub"
#    public_key  = "${file("joc-key-pair.pub")}"
#}


# generem la clau un cop de manera automàtica

resource "tls_private_key" "demo_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "demo_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.demo_key.public_key_openssh
  
  provisioner "local-exec"{
    command = "echo '${tls_private_key.demo_key.private_key_openssh}' > ./${var.key_pair_name}.pem"
  }

  tags = {
    "Owner"               = var.owner
    "Name"                = "${var.owner}-instance"
  }
}
