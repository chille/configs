Ubuntu base installation
========================

This is the base setup I use on most computers.

Note: I have previously been installing from mini.iso This file was created / updated from a Ubuntu 19.04 desktop minimal installation. A lot of packages are included, compared to an installation from mini.iso. Some more packages might be needed when installing from a mini.iso. See the TODO's.


Installation
------------

# Ubuntu 19.04 minimal installation from mini.iso
# Or "Minimal installation" from ubuntu-19.04-desktop-amd64.iso

# Turn off recommends/suggests - do not install annoying crap
echo -e "APT::Install-Recommends \"0\";\nAPT::Install-Suggests \"0\";" >> /etc/apt/apt.conf.d/99chille

# A better shell
apt-get install tcsh
chsh -s /bin/tcsh

# Standard tools
apt-get install openssh-server
apt-get install git
apt-get install tcc
apt-get install tree
apt-get install htop
apt-get install ntp
apt-get install nmap
apt-get install unrar
apt-get install unzip # TODO: Still needed with 19.04 mini.iso?
apt-get install firefox
apt-get install wireshark
apt-get install keepassxc
apt-get install speedcrunch

# apt-file
apt-get install apt-file
apt-file update

# For add-apt-repository
apt-get install software-properties-common # TODO: Still needed with 19.04 mini.iso?

# Application configuration files
git clone https://github.com/chille/configs
ln -s /home/chille/configs/tcshrc /home/chille/.tcshrc
ln -s /home/chille/configs/ROXTerm/ /home/chille/.config/roxterm.sourceforge.net
ln -s /home/chille/configs/awesome/ /home/33chille/.config/awesome
ln -s /home/chille/configs/dot.xinitrc /home/chille/.xinitrc
ln -s /home/chille/configs/tmux.conf /home/chille/.tmux.conf
sudo ln -s /home/chille/configs/tcshrc /root/.tcshrc
sudo ln -s /home/chille/configs/keyboardlayout /usr/share/X11/xkb/symbols/chille

# Only needed on MacBook 15": DPI Settings
sudo ln -s /home/chille/configs/Xresources /home/chille/.Xresources

# Only needed on MacBook's: mtrack driver
apt-get install xserver-xorg-input-mtrack
sudo ln -s /home/chille/configs/50-mtrack.conf /usr/share/X11/xorg.conf.d/50-mtrack.conf
Disable "libinput touchpad catchall" in /usr/share/X11/xorg.conf.d/40-libinput.conf

# Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Sublime configuration
mkdir -p /home/chille/.config/sublime-text-3/Packages/User
ln -s /home/chille/configs/Sublime3/Default\ \(Linux\).sublime-keymap /home/chille/.config/sublime-text-3/Packages/User/

# ROXTerm
add-apt-repository ppa:h-realh/roxterm
apt-get update
apt-get install roxterm

# Window manager: Awesome
apt-get install awesome

# Make the keyboard backlight work on MacBook's
echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"\nACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"\n\nACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", RUN+="/bin/chgrp video /sys/class/leds/%k/brightness"\nACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"\n' > /etc/udev/rules.d/backlight.rules
addgroup chille video

# Note: apple_backlight on 2010 13" and gmux_backlight on 2013 15"

# If using Ubuntu desktop we need to make sure no GUI is started
systemctl enable multi-user.target
systemctl set-default multi-user.target


Terminal: st
------------
sudo apt-get install libxft-dev
git clone https://git.suckless.org/st
cd st
wget https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff
wget https://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.1.diff
patch < st-anysize-0.8.1.diff
patch < st-hidecursor-0.8.1.diff
nano config.h
make


Todo
----
# Keyboard sharing?
apt-get install barrier