variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet_id" {
  description = "ID of the public Subnet"
}

variable "algorand_mainnet_instance_type" {
  description = "Algorand Mainnet Instance Type"
  default = "t3.xlarge"
}
