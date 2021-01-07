data "aws_ami" "algorand" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20201014"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "algorand_mainnet_sg" {

  name   = "algorand_mainnet_sg"

  vpc_id = var.vpc_id

  # SSH access from the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Algorand Node"
    Network = "Mainnet"
  }
}
  
data "template_file" "user_data" {
  template = file("${path.cwd}/${path.module}/scripts/add-ssh-web-app.yaml")
  vars = {
    ssh_key = file("${path.cwd}/../keys/tf-cloud-init.pub")
    install_algorand = base64encode(file("${path.cwd}/../scripts/install-algorand.sh"))
  }
}

resource "aws_instance" "algorand_mainnet" {

  ami                         = data.aws_ami.algorand.id
  instance_type               = var.algorand_mainnet_instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.algorand_mainnet_sg.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered

  root_block_device {
    // volume_size = "90"
    delete_on_termination = true
  }

  tags = {
    Name = "Algorand Node"
    Network = "Mainnet"
  }
}
