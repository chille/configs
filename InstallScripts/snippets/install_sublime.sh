#!/bin/bash

# Include configuration
source "${BASH_SOURCE%/*}/../functions.sh"

# Check that we are root and sudo if not
#run_as_root

# Sublime configuration
mkdir -p /home/$USERNAME/.config/sublime-text-3/Packages/User
ln    -s /home/$USERNAME/configs/Sublime3/Default\ \(Linux\).sublime-keymap /home/$USERNAME/.config/sublime-text-3/Packages/User/
ln    -s /home/$USERNAME/configs/Sublime3/Preferences.sublime-settings      /home/$USERNAME/.config/sublime-text-3/Packages/User/

# Install Sublime
if [ ! -f /etc/apt/trusted.gpg.d/sublimehq-archive.gpg ]; then
	echo "Setting Sublime apt key and sources"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

	sudo apt-get update
else
	echo "Sublime apt key and sources already set"
fi

# Run apt-get update if not done recently
apt_update

sudo apt-get install sublime-text
