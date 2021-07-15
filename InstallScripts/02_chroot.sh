#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Mount the device into our mountpoint
mount_device

# Create mountpoint for debootstrap scripts, if it does not already exist
if [ ! -d "$MOUNTPOINT/mnt/host" ]; then
	echo "Creating $MOUNTPOINT/mnt/host"
        mkdir $MOUNTPOINT/mnt/host
fi

# Bind mount everything needed
mount --rbind /dev  $MOUNTPOINT/dev
mount --rbind /proc $MOUNTPOINT/proc
mount --rbind /sys  $MOUNTPOINT/sys
mount --bind . $MOUNTPOINT/mnt/host

# chroot into the system
echo "Chrooting into system"
chroot $MOUNTPOINT bash --login

# TODO: Should we unmount? Is it possible to do a recusrive unmount (the opposite to mount --rbind)?
