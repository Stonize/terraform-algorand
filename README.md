<p align="center">
  <a href="http://stonize.com/" target="blank"><img src="https://stonize.com/static/media/logo_2.b1e2c59b.png" width="320" alt="Stonize Logo" /></a>
</p>

# README

This project aims to create an Algorand Node (testnet, mainnet) on AWS infrastructure.

# Install Terraform

You need to install Terraform to provision your infrastructure: https://learn.hashicorp.com/terraform.
If you want to go fast you can use `install-terraform.sh` in `scripts` directory.

# Key generation

The terrafor configuration creates an EC2 instance with a VPN: in order to access the newly created 
host you need to invoke: 

```
ssh-keygen -t rsa -C "example@example.com" -f keys/tf-cloud-init
```

# Prerequisite

You need to have a valid AWS keys configured in your HOME path (credential and secret)

# Node creation (TestNet)

In order to create the node you need to enter in `instances` directory and invoke:

`terraform init`

`terraform apply`

When the system ask you for confirmation you need to write `yes`.
The final output of the Terraform script is the IP and DNS of the EC2 instance.

Wait about 5 minute to give time the CloudInit script to:
- setup python and environment
- download the Algorand node software
- configure it
- download the TestNet catchpoint from S3 bucket from AWS
- run all the daemons

You can enter in the EC2 instance with ssh:

```
ssh -i ../keys/tf-cloud-init terraform@IP_OF_EC2_HOST
```

Enter in the `node` directory

```
cd node
```

and observe the consensus protocol running with:

```
./carpenter -d testnetdata
```

# Customize

You can finally use your node to interact via APIs with the Algorand TestNet using token.
The token is in the host and you can read it with the following:

```
cat /home/terraform/node/testnetdata/algod.token
```

The Algorand Node's API is listening at port 8080 and is reachble from outside.
