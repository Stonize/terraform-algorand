output "mainnet_public_dns" {
  value = aws_instance.algorand_mainnet.public_dns
}

output "mainnet_public_ip" {
  value = aws_instance.algorand_mainnet.public_ip
}