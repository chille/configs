#!/bin/bash

# Include configuration
source "${BASH_SOURCE%/*}/../functions.sh"

# Run apt-get update if not done recently
apt_update

# Install Sway window manager
sudo apt-get install --yes sway swayidle swaylock waybar fonts-font-awesome wev python3-i3ipc foot grim grimshot
# Note: wev is a tool used for debugging events in Wayland

# Required to change screen and keyboard brightness
sudo addgroup $USERNAME video
sudo addgroup $USERNAME input

# Symlink Sway config
mkdir -p /home/$USERNAME/.config/sway
ln -s /home/$USERNAME/configs/sway/config /home/$USERNAME/.config/sway/config

# Symlink Waybar config
mkdir -p /home/$USERNAME/.config/waybar
ln -s /home/$USERNAME/configs/waybar/config    /home/$USERNAME/.config/waybar/config
ln -s /home/$USERNAME/configs/waybar/style.css /home/$USERNAME/.config/waybar/style.css

# Symlink foot config
mkdir -p /home/$USERNAME/.config/foot
ln -s /home/$USERNAME/configs/foot /home/$USERNAME/.config/foot/foot.ini

if [ -f /usr/share/wayland-sessions/sway.desktop ]; then
	sudo sed -i "s/Exec\=sway/Exec\=\/home\/$USERNAME\/configs\/bin\/startsway.sh/g" /usr/share/wayland-sessions/sway.desktop
fi
