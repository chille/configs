#!/bin/sh

sudo apt-get install --no-install-recommends -y libxft-dev

cd ~/configs/

# Clone git repository
git clone https://git.suckless.org/st
cd st/

# Download and apply patches
wget https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff
wget https://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.3.diff
wget https://st.suckless.org/patches/defaultfontsize/st-defaultfontsize-20210225-4ef0cbd.diff
patch < st-anysize-0.8.1.diff
patch < st-hidecursor-0.8.3.diff
patch < st-defaultfontsize-20210225-4ef0cbd.diff

ln -s ~/configs/st_config.h config.h
make