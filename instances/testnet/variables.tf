variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet_id" {
  description = "ID of the public Subnet"
}

variable "algorand_testnet_instance_type" {
  description = "Algorand Testnet Instance Type"
  default = "t3.medium"
}
