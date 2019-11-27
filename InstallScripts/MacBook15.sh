#!/bin/bash

# Only needed on MacBook 15": DPI Settings
sudo ln -s /home/chille/configs/Xresources /home/chille/.Xresources

# Make the keyboard backlight work on MacBook's
echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="gmux_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"\nACTION=="add", SUBSYSTEM=="backlight", KERNEL=="ap>
addgroup chille video

