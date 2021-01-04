output "testnet_public_dns" {
  value = aws_instance.algorand_testnet.public_dns
}

output "testnet_public_ip" {
  value = aws_instance.algorand_testnet.public_ip
}