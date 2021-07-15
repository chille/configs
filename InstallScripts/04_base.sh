#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Turn off recommends/suggests - do not install annoying crap
echo -e "APT::Install-Recommends \"0\";\nAPT::Install-Suggests \"0\";" > /etc/apt/apt.conf.d/99no-install-recommends

# Create a new sources.list with all repositories enabled
generatesourceslist() {
	cat <<EOF
deb     http://archive.ubuntu.com/ubuntu hirsute          main universe restricted multiverse
deb-src http://archive.ubuntu.com/ubuntu hirsute          main universe restricted multiverse
deb     http://archive.ubuntu.com/ubuntu hirsute-updates  main universe restricted multiverse
deb-src http://archive.ubuntu.com/ubuntu hirsute-updates  main universe restricted multiverse
deb     http://archive.ubuntu.com/ubuntu hirsute-security main universe restricted multiverse
deb-src http://archive.ubuntu.com/ubuntu hirsute-security main universe restricted multiverse
EOF
}
generatesourceslist > /etc/apt/sources.list

# Update our repositories
apt-get update

# Install some basic tools
apt-get install --no-install-recommends --yes \
	tcsh \
	nano \
	openssh-server \
	ethtool \
	tmux \
	tree \
	unzip \
	unrar \
	nmap \
	htop \
	openssh-server \
	apt-file \
	curl \
	git \
	software-properties-common \
	locate

# Update locate database
updatedb

# Note software-properties-common is for add-apt-repository

# Change shell to tcsh
usermod --shell /bin/tcsh $USERNAME

# Update apt-file
sudo apt-file update

# Application configuration files
sudo -H -u $USERNAME git clone https://github.com/chille/configs /home/$USERNAME/configs
sudo -H -u $USERNAME ln -s /home/chille/configs/tcshrc /home/$USERNAME/.tcshrc
sudo -H -u $USERNAME ln -s /home/chille/configs/tmux.conf /home/$USERNAME/.tmux.conf
ln -s /home/chille/configs/tcshrc /root/.tcshrc
