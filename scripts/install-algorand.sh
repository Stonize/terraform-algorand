#!/bin/bash

# Fail script on first error
set -e

# This can be archive or light
NODE_TYPE=$1

# This can be testnet or mainnet
NETWORK=$2

cd /home/terraform

sudo apt update

sudo apt install -y python3-pip

wget https://raw.githubusercontent.com/algorand/go-algorand-doc/master/downloads/installers/update.sh

chmod 544 update.sh

# First startup
./update.sh -i -c stable -p ~/node -d ~/node/data -n

# Switch to the selected network

if [ "${NETWORK}" == "testnet" ] ; then

    cd ~/node

    mkdir testnetdata 

    cp ~/node/genesisfiles/testnet/genesis.json ~/node/testnetdata

    cp ~/node/data/config.json.example ~/node/testnetdata/config.json

    # Open to external connections at port 8080
    sed -i 's/"EndpointAddress": "127.0.0.1:0"/"EndpointAddress": "0.0.0.0:8080"/g' ~/node/testnetdata/config.json

    export ALGORAND_DATA=~/node/testnetdata

fi

if [ "${NETWORK}" == "mainnet" ] ; then

    cp ~/node/data/config.json.example ~/node/data/config.json

    # Open to external connections at port 8080
    sed -i 's/"EndpointAddress": "127.0.0.1:0"/"EndpointAddress": "0.0.0.0:8080"/g' ~/node/data/config.json

    export ALGORAND_DATA=~/node/data

fi

~/node/goal node start

~/node/goal kmd start

~/node/goal node status

# Catchup testnet data
# source: https://developer.algorand.org/docs/run-a-node/setup/install/ (see link for testnet)
~/node/goal node catchup $(curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/${NETWORK}/latest.catchpoint) -d ~/node/data/
