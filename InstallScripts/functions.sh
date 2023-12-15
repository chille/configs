#!/bin/bash

# Include configuration
#source config.sh
source "${BASH_SOURCE%/*}/config.sh"

check_root () {
	# Check that the script is executed by root
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root"
		exit
	fi
}

run_as_root () {
	if [[ ($USER != root) ]]; then
		sudo $0 $1
		exit 0
	fi
}

# Create mountpoint and mount filesystem
mount_device () {
	# Create MOUNTPOINT directory, if it does not already exist
	if [ ! -d "$MOUNTPOINT" ]; then
		echo "Creating $MOUNTPOINT"
		mkdir $MOUNTPOINT
	fi

	# Check if the volume is already mounted
	if grep -qs "$DEVICE " /proc/mounts; then
		# Check that it is mounted into the correct mountpoint
		if grep -qs "$DEVICE $MOUNTPOINT " /proc/mounts; then
			echo "$DEVICE is already mounted into $MOUNTPOINT"
		else
			echo "Error: $DEVICE is mounted into the wrong mountpoint"
			exit
		fi
	else
		# Mount filesystem
		echo "Mounting $DEVICE into $MOUNTPOINT"
		mount $DEVICE $MOUNTPOINT
	fi

	# Check that mount was successful
	if ! grep -qs "$DEVICE $MOUNTPOINT " /proc/mounts; then
		echo "Error: Could not mount filesystem"
		exit
	fi
}

apt_update () {
	if [ `find /var/lib/apt/periodic/update-success-stamp -mmin +10` ]; then
		sudo apt-get update
	fi
}
