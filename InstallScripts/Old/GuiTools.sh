#!/bin/bash

# GUI tools
sudo apt-get install -y --no-install-recommends \
	firefox \
	wireshark \
	keepassxc \
	speedcrunch \
	okular \
	mirage \
	mesa-utils \
	nextcloud-desktop

# Note mesa-utils is for glxinfo and glxgears

# Sublime configuration
mkdir -p /home/chille/.config/sublime-text-3/Packages/User
ln -s /home/chille/configs/Sublime3/Default\ \(Linux\).sublime-keymap /home/chille/.config/sublime-text-3/Packages/User/
ln -s /home/chille/configs/Sublime3/Preferences.sublime-settings /home/chille/.config/sublime-text-3/Packages/User/

# Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# ROXTerm
sudo add-apt-repository ppa:h-realh/roxterm
sudo apt-get update
sudo apt-get install roxterm

# If using Ubuntu desktop we need to make sure no GUI is started
sudo systemctl enable multi-user.target
sudo systemctl set-default multi-user.target
