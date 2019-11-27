#!/bin/bash

# GUI tools
sudo apt-get install -y --no-install-recommends \
	awesome \
	firefox \
	wireshark \
	keepassxc \
	speedcrunch \
	okular \
	mirage \
	mesa-utils

# Note mesa-utils is for glxinfo and glxgears

# Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# If using Ubuntu desktop we need to make sure no GUI is started
sudo systemctl enable multi-user.target
sudo systemctl set-default multi-user.target

# Application configuration files
ln -s /home/chille/configs/ROXTerm/ /home/chille/.config/roxterm.sourceforge.net/
ln -s /home/chille/configs/awesome/ /home/chille/.config/awesome/
ln -s /home/chille/configs/dot.xinitrc /home/chille/.xinitrc
sudo ln -s /home/chille/configs/keyboardlayout /usr/share/X11/xkb/symbols/chille

# Sublime configuration
mkdir -p /home/chille/.config/sublime-text-3/Packages/User
ln -s /home/chille/configs/Sublime3/Default\ \(Linux\).sublime-keymap /home/chille/.config/sublime-text-3/Packages/User/
