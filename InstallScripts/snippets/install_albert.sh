#!/bin/bash

# Include configuration
source "${BASH_SOURCE%/*}/../functions.sh"

# Check that we are root and sudo if not
run_as_root

# Install Albert (Application launcher)

# Download the *.deb file
wget --output-document /tmp/albert_0.17.6-0_amd64.deb https://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_22.04/amd64/albert_0.17.6-0_amd64.deb

# Try to install it, this will most likely fail because we don't have the needed dependencies
dpkg --install /tmp/albert_0.17.6-0_amd64.deb

# Install dependencies
apt-get update
apt-get install -f

# Install it again
dpkg --install /tmp/albert_0.17.6-0_amd64.deb

# Remove the install file
rm /tmp/albert_0.17.6-0_amd64.deb
