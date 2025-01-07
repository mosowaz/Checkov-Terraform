#!/bin/bash

set -euxo pipefail          # fail hard incase of any errors or typo

sudo apt update
sudo apt install pipx       
pipx install checkov        # by default packages installed with pipx are located in "$USER/.local/bin"
pipx ensurepath             # add installed packages into "$PATH"
source ~/.bashrc
