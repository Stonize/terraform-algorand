variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "cidr_public_subnet" {
  description = "CIDR block for the public subnet"
  default     = "10.1.0.0/24"
}

variable "region"{
  description = "The region Terraform deploys your instance"
  default = "eu-west-1"
}

#variable "accesskey" {
#  description = "AWS ACCESS_KEY"
#}

#variable "secretkey" {
#  description = "AWS SECRET_KEY"
#}
