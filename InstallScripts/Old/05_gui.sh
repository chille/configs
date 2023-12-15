#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Install Xorg and Awesome (With a crappy framebuffer driver)
apt-get install --yes \
	xserver-xorg-core \
	xserver-xorg-video-fbdev \
	xserver-xorg-input-evdev \
	x11-xserver-utils \
	awesome \
	xinit \
	mesa-utils

# Note: x11-xserver-utils is used for xset
# Note: mesa-utils is for glxinfo and glxgears

# Needed to get access to /dev/fb0 when using fbdev driver
addgroup $USERNAME video

# Application configuration files
sudo -H -u $USERNAME mkdir -p /home/$USERNAME/.config
sudo -H -u $USERNAME ln -s /home/$USERNAME/configs/ROXTerm/ /home/$USERNAME/.config/roxterm.sourceforge.net
sudo -H -u $USERNAME ln -s /home/$USERNAME/configs/awesome/ /home/$USERNAME/.config/awesome
sudo -H -u $USERNAME ln -s /home/$USERNAME/configs/dot.xinitrc /home/$USERNAME/.xinitrc
ln -s /home/$USERNAME/configs/keyboardlayout /usr/share/X11/xkb/symbols/chille
