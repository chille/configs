#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Check that debootstrap is installed
if [ ! command -v debootstrap &> /dev/null ]; then
	echo "Error: debootstrap is not installed"
	exit
fi

# Mount the device into our mountpoint
mount_device

# Check that the filesystem is empty (Should only contain a lost+found directory)
files2=`ls -A $MOUNTPOINT`
if [ "$files2" != "lost+found" ]; then
	echo Filesystem does not seem to be empty
	exit
fi

# Install Ubuntu 21.04
debootstrap kinetic $MOUNTPOINT
