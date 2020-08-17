#!/bin/sh

CURRENT=`uname -a | cut -d\  -f3 | cut -d- -f1-2`
echo Current version: $CURRENT

KERNELS=`dpkg --list | egrep "(linux-headers|linux-image|linux-modules)" | egrep -v "(linux-headers-generic|linux-image-generic)" | grep -v $CURRENT | cut -d\  -f 3`
echo Removing $KERNELS

sudo apt remove --purge $KERNELS
