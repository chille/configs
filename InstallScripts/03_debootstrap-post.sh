#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Set hostname
echo $HOSTNAME > /etc/hostname

# Add hostname to /etc/hosts
echo "Checking for 127.0.1.1 in /etc/hosts"
if grep -qs "127.0.1.1" /etc/hosts
then
	echo Already there
else
	echo Adding "127.0.1.1\t${HOSTNAME}"
	sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\tlocalhost\n127.0.1.1\t${HOSTNAME}/g" /etc/hosts
fi

# Turn off recommends/suggests - do not install annoying crap
echo -e "APT::Install-Recommends \"0\";\nAPT::Install-Suggests \"0\";" > /etc/apt/apt.conf.d/99no-install-recommends

# Generate a new /etc/fstab
echo -e "UUID=`blkid -s UUID -o value $DEVICE`\t/\text4\terrors=remount-ro\t0\t1" > /etc/fstab

# Create a new sources.list with all repositories enabled
generatesourceslist() {
	cat <<EOF
deb      http://se.archive.ubuntu.com/ubuntu/ mantic           main universe restricted multiverse
deb-src  http://se.archive.ubuntu.com/ubuntu/ mantic           main universe restricted multiverse
deb      http://se.archive.ubuntu.com/ubuntu/ mantic-updates   main universe restricted multiverse
deb-src  http://se.archive.ubuntu.com/ubuntu/ mantic-updates   main universe restricted multiverse
deb      http://security.ubuntu.com/ubuntu    mantic-security  main universe restricted multiverse
deb-src  http://security.ubuntu.com/ubuntu    mantic-security  main universe restricted multiverse
#deb     http://se.archive.ubuntu.com/ubuntu/ mantic-backports main universe restricted multiverse
#deb-src http://se.archive.ubuntu.com/ubuntu/ mantic-backports main universe restricted multiverse
EOF
}
generatesourceslist > /etc/apt/sources.list

# MacBook A4121 (MacBook Pro 2019 16") needs a special T2 kernel
if [ "$HOSTNAME" = "chille-macbook16" ]; then
	cp /mnt/host/assets/t2-ubuntu-repo.gpg /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg
        echo "deb [signed-by=/etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg] https://adityagarg8.github.io/t2-ubuntu-repo ./" > /etc/apt/sources.list.d/t2.list
fi

# Update the APT repositories
apt-get update

# The added repositories might come with updated software
apt-get upgrade --yes
apt-get dist-upgrade --yes

# Some basic tools like curl are needed to run the `update_t2_kernel`
# So lets install everything in the base system before we continue with the kernel

# Install some base tools
./snippets/install_basetools.sh

# Install latest Linux kernel
if [ "$HOSTNAME" = "chille-macbook16" ]; then
	echo Installing latest T2 kernel
	apt-get install --yes t2-kernel-script
#	update_t2_kernel
else
	apt install --yes linux-image-generic
fi

# Create initrd
#apt install --yes --no-install-recommends initramfs-tools
#KERNEL=`ls /usr/lib/modules/ | cut -d/ -f1 | sed 's/linux-image-//'`
#update-initramfs -u -k $KERNEL

#apt install --yes --no-install-recommends tiny-initramfs

# Cleanup after installation and update
apt-get autoremove
apt-get autoclean

# Update locate database
updatedb

# Update apt-file
sudo apt-file update

# Set timezone to Europe/Stockholm
ln -fs /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

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

# Set keyboard layout to Swedish Mac keyboard
cat << 'EOF' > /etc/default/keyboard
XKBMODEL="pc105"
XKBLAYOUT="se"
XKBVARIANT="mac"
XKBOPTIONS=""
BACKSPACE="guess"
EOF

# Create user (Do not set a password yet)
useradd --groups sudo --create-home $USERNAME

# Change shell to tcsh
usermod --shell /bin/tcsh $USERNAME

# Update TLDR database
sudo -H -u $USERNAME tldr --update

# Application configuration files
sudo -H -u $USERNAME git clone https://github.com/chille/configs /home/$USERNAME/configs
sudo -H -u $USERNAME ln -s /home/chille/configs/tcshrc /home/$USERNAME/.tcshrc
sudo -H -u $USERNAME ln -s /home/chille/configs/tmux.conf /home/$USERNAME/.tmux.conf
ln -s /home/chille/configs/tcshrc /root/.tcshrc

# Create user password
#passwd $USERNAME
