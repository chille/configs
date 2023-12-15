#!/bin/bash

# Include configuration
source "${BASH_SOURCE%/*}/../functions.sh"

# Run apt-get update if not done recently
apt_update

# Install some basic tools
sudo apt-get install --yes --no-install-recommends \
	tcsh \
	nano \
	openssh-server \
	ethtool \
	tmux \
	tree \
	file \
	unzip \
	unrar \
	nmap \
	htop \
	smartmontools \
	apt-file \
	curl \
	git \
	software-properties-common \
	pciutils \
	usbutils \
	locate \
	man \
	tldr

# Note: software-properties-common is for add-apt-repository
# Note: pciutils is for lspci
# Note: usbutils is for lsusb
