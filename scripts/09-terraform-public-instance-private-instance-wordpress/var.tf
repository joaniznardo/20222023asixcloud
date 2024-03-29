# variables.tf
 
# Variables for general information
######################################
 
variable "profile" {
  description = "choose one"
  type        = string
#  default     = "us-east-1"
}
variable "aws_region" {
  description = "AWS region"
  type        = string
#  default     = "us-east-1"
}
 
variable "owner" {
  description = "Configuration owner"
  type        = string
}
 
variable "aws_region_az" {
  description = "AWS region availability zone"
  type        = string
#  default     = "a"
}
 
 
# Variables for VPC
######################################
 
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
#  default     = "10.0.0.0/16"
}
 
variable "vpc_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
#  default     = true
}
 
variable "vpc_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
#  default     = true
}
 
 
# Variables for Security Group
######################################
 
variable "sg_ingress_proto" {
  description = "Protocol used for the ingress rule"
  type        = string
#  default     = "tcp"
}
 
variable "sg_ingress_ssh" {
  description = "Port used for the ingress rule"
  type        = string
#  default     = "22"
}
 
variable "sg_egress_proto" {
  description = "Protocol used for the egress rule"
  type        = string
#  default     = "-1"
}
 
variable "sg_egress_all" {
  description = "Port used for the egress rule"
  type        = string
#  default     = "0"
}
 
variable "sg_egress_cidr_block" {
  description = "CIDR block for the egress rule"
  type        = string
#  default     = "0.0.0.0/0"
}
 
variable "sg_ingress_cidr_block" {
  description = "CIDR block for the ingress rule"
  type        = string
#  default     = "0.0.0.0/0"
}
 
 
# Variables for Subnet
######################################
 
variable "sbn_public_ip" {
  description = "Assign public IP to the instance launched into the subnet"
  type        = bool
  default     = true
}
variable "sbn_private_ip" {
  description = "NOT assign public IP to the instance launched into the subnet"
  type        = bool
  default     = false
}
 
variable "sbn_public_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
#  default     = "10.0.1.0/24"
}
 
variable "sbn_private_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
#  default     = "10.0.2.0/24"
}
 
 
# Variables for Route Table
######################################
 
variable "rt_cidr_block" {
  description = "CIDR block for the route table"
  type        = string
#  default     = "0.0.0.0/0"
}
 
 
# Variables for Instance
######################################
 
variable "instance_ami" {
  description = "ID of the AMI used"
  type        = string
  #default     = "ami-0211d10fb4a04824a"
#  default     = "ami-04ad2567c9e3d7893"

}
 
variable "instance_type" {
  description = "Type of the instance"
  type        = string
  #default     = "t2.medium"
#  default     = "t2.micro"
}
 
variable "key_pair_name" {
  description = "SSH Key pair used to connect"
  type        = string
}

variable "install_script_name_public_instance" {
  description = "cloud init data"
  type        = string
#  default     = "silent-install-public.sh"
}
 
variable "install_script_name_private_instance" {
  description = "cloud init data"
  type        = string
#  default     = "silent-installi-private.sh"
}
 
variable "root_device_type" {
  description = "Type of the root block device"
  type        = string
#  default     = "gp2"
}
 
variable "root_device_size" {
  description = "Size of the root block device"
  type        = string
#  default     = "50"
}
