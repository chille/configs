# GUI tools
sudo apt-get install -y --no-install-recommends \
        firefox \
        wireshark \
        keepassxc \
        speedcrunch \
        okular \
        mirage \
        nextcloud-desktop

# ROXTerm
sudo add-apt-repository ppa:h-realh/roxterm
sudo apt-get update
sudo apt-get install roxterm

# If using Ubuntu desktop we need to make sure no GUI is started
sudo systemctl enable multi-user.target
sudo systemctl set-default multi-user.target





sudo ln -s /home/chille/configs/Xresources /home/chille/.Xresources



wicd-gtk
