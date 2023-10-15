#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Turn off recommends/suggests - do not install annoying crap
echo -e "APT::Install-Recommends \"0\";\nAPT::Install-Suggests \"0\";" > /etc/apt/apt.conf.d/99no-install-recommends

# Update our repositories
apt-get update

# The added repositories might come with updated software
apt-get upgrade --yes
apt-get dist-upgrade --yes

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
	locate \
	pciutils \
	usbutils \
	smartmontools \
	man \
	tldr

# Note: software-properties-common is for add-apt-repository
# Note: pciutils is for lspci
# Note: usbutils is for lsusb

# Cleanup after installation and update
apt-get autoremove
apt-get autoclean

# Update locate database
updatedb

# Update TLDR database
sudo -H -u $USERNAME tldr --update

# Change shell to tcsh
usermod --shell /bin/tcsh $USERNAME

# Update apt-file
sudo apt-file update

# Application configuration files
sudo -H -u $USERNAME git clone https://github.com/chille/configs /home/$USERNAME/configs
sudo -H -u $USERNAME ln -s /home/chille/configs/tcshrc /home/$USERNAME/.tcshrc
sudo -H -u $USERNAME ln -s /home/chille/configs/tmux.conf /home/$USERNAME/.tmux.conf
ln -s /home/chille/configs/tcshrc /root/.tcshrc

# Set locale to use the English language, but Swedish numbers, currency, etc
locale-gen --purge en_US.UTF-8 sv_SE.UTF-8
update-locale \
	LANG=en_US.UTF-8 \
	LC_NAME=sv_SE.UTF-8 \
	LC_IDENTIFICATION=sv_SE.UTF-8 \
	LC_MEASUREMENT=sv_SE.UTF-8 \
	LC_NUMERIC=sv_SE.UTF-8 \
	LC_TIME=sv_SE.UTF-8 \
	LC_PAPER=sv_SE.UTF-8 \
	LC_MONETARY=sv_SE.UTF-8 \
	LC_TELEPHONE=sv_SE.UTF-8 \
	LC_CTYPE=en_US.UTF-8 \
	LC_ADDRESS=sv_SE.UTF-8
dpkg-reconfigure --frontend noninteractive locales

# Set timezone to Europe/Stockholm
ln -fs /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Set keyboard layout to Swedish Mac keyboard
cat << 'EOF' > /etc/default/keyboard
XKBMODEL="pc105"
XKBLAYOUT="se"
XKBVARIANT="mac"
XKBOPTIONS=""
BACKSPACE="guess"
EOF
