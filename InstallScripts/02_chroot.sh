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
mount --rbind /dev $MOUNTPOINT/dev
mount --make-rslave $MOUNTPOINT/dev
mount -t proc /proc $MOUNTPOINT/proc
mount -t sysfs /sys $MOUNTPOINT/sys
mount --bind . $MOUNTPOINT/mnt/host

# chroot into the system
echo "Chrooting into system"

if [ ! -f /usr/bin/tcsh ]; then
	chroot $MOUNTPOINT bash --login
else
	chroot $MOUNTPOINT tcsh
fi

# Unmount everything
sudo umount --recursive /mnt/target

echo "Exited from chrooted system"
