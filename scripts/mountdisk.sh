#!/bin/bash

sudo mkfs -t ext4 /dev/nvme1n1
mkdir node
mount /dev/nvme1n1 $(pwd)/node
chown terraform:hashicorp node
