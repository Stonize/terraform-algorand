#!/bin/bash

# source: https://learn.hashicorp.com/tutorials/terraform/install-cli

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Install terragrunt
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.25.4/terragrunt_linux_amd64 -O terragrunt
chmod +x terragrunt
sudo mv terragrunt /usr/local/bin