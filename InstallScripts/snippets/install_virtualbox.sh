#!/bin/bash

# Include configuration
source "${BASH_SOURCE%/*}/../functions.sh"

# Run apt-get update if not done recently
apt_update

# Install Sway window manager
sudo apt-get install --yes --no-install-recommends virtualbox virtualbox-guest-additions-iso
