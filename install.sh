#!/bin/bash

######## Checkov Installation ########
set -euxo pipefail 

which checkov
if [ $? -eq 0 ]; then
 exit 0
else
  sudo apt-get update
  sudo apt-get install -y pipx       
  pipx install checkov        # by default packages installed with pipx are located in "$USER/.local/bin"
  pipx upgrade checkov
  pipx ensurepath             # add installed packages into "$PATH"
  source ~/.bashrc
fi

######## Terraform installation ########
which terraform

if [ $? -eq 0 ]; then
 exit 0
else
  sudo apt-get update && sudo apt-get install -y gnupg wget curl software-properties-common

  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

  gpg --no-default-keyring \
      --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
      --fingerprint

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
      https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
      sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt-get update && sudo apt-get install -y terraform
fi

terraform version && checkov --version
