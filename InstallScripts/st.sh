#!/bin/sh

sudo apt-get install --no-install-recommends -y libxft-dev
cd /home/chille/configs/
git clone https://git.suckless.org/st
cd st/
wget https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff
wget https://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.1.diff
patch < st-anysize-0.8.1.diff
patch < st-hidecursor-0.8.1.diff
ln -s /home/chille/configs/st_config.h config.h
make
