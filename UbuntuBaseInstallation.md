Ubuntu base installation
========================

This is the base setup I use on most computers.

Note: I have previously been installing from mini.iso This file was created / updated from a Ubuntu 19.04 desktop minimal installation. A lot of packages are included, compared to an installation from mini.iso. Some more packages might be needed when installing from a mini.iso. See the TODO's.


Installation
------------

# Ubuntu 19.04 minimal installation from mini.iso
# Or "Minimal installation" from ubuntu-19.04-desktop-amd64.iso

# Run install scripts
./InstallScripts/BaseSystem.sh
./InstallScripts/GuiTools.sh
./InstallScripts/MacBook15.sh (UNTESTED)
./InstallScripts/MacBook15.sh (UNTESTED)

# Only needed on MacBook's: mtrack driver
apt-get install xserver-xorg-input-mtrack
sudo ln -s /home/chille/configs/50-mtrack.conf /usr/share/X11/xorg.conf.d/50-mtrack.conf
Disable "libinput touchpad catchall" in /usr/share/X11/xorg.conf.d/40-libinput.conf

# ROXTerm
add-apt-repository ppa:h-realh/roxterm
apt-get update
apt-get install roxterm


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

 * Eth card names
 * Scripts should check for existing files before creating symlinks
