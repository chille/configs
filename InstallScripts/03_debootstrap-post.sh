#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Generate a new /etc/fstab
echo -e "UUID=`blkid -s UUID -o value $DEVICE`\t/\text4\terrors=remount-ro\t0\t1" > /etc/fstab

# Install latest Linux kernel
apt install --yes --no-install-recommends linux-image-generic

# Create initrd
#apt install --yes --no-install-recommends initramfs-tools
#KERNEL=`ls /usr/lib/modules/ | cut -d/ -f1 | sed 's/linux-image-//'`
#update-initramfs -u -k $KERNEL

apt install --yes --no-install-recommends tiny-initramfs

# Create user and set password
useradd --groups sudo --create-home $USERNAME
passwd $USERNAME
