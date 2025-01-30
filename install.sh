#!/bin/bash

set -euxo pipefail          # fail hard incase of any errors or typo
######## Checkov Installation ########
sudo apt-get update
sudo apt-get install pipx       
pipx install checkov        # by default packages installed with pipx are located in "$USER/.local/bin"
pipx ensurepath             # add installed packages into "$PATH"
source ~/.bashrc

######## Terraform installation ########

sudo apt-get update && sudo apt-get install -y gnupg wget curl software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
   sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install terraform

terraform version 
checkov --version
