#!/bin/bash

# Turn off recommends/suggests - do not install annoying crap
echo -e "APT::Install-Recommends \"0\";\nAPT::Install-Suggests \"0\";" | sudo tee /etc/apt/apt.conf.d/99chille

# Terminal tools
sudo -- apt-get install -y --no-install-recommends \
	openssh-server \
	tree \
	htop \
	systemd-timesyncd \
	nmap \
	unrar \
	unzip \
	tmux \
	tcsh \
	apt-file \
	software-properties-common \
	curl \
	docker.io

# Note software-properties-common is for add-apt-repository
# TODO: Is unzip still needed with 19.04 mini.iso?
# TODO: Is software-properties-common still needed with 19.04 mini.iso?
# TODO: Replaced ntp with systemd-timesyncd, is it already included in mini.iso?

# Change shell
chsh -s /bin/tcsh

# Update apt-file
sudo apt-file update

# Application configuration files
ln -s /home/chille/configs/tcshrc /home/chille/.tcshrc
ln -s /home/chille/configs/tmux.conf /home/chille/.tmux.conf
sudo ln -s /home/chille/configs/tcshrc /root/.tcshrc