#!/bin/bash

if [ `hostname` = "chille-desktop" ]; then
	# For Apple keyboards
	echo "Setting keymap for Apple keyboard"
	setxkbmap -rules evdev -model evdev -layout chille
else
	# For laptop
	echo "Setting keymap for PC keyboard";
	setxkbmap -rules evdev -model evdev -layout chille -variant mixed
fi

# Never turn off screen
#xset -dpms

# Turn of screen after 1 hour
xset dpms 3600 3600 3600

# No screensaver or blanking
xset s off
xset s noblank

# Start window manager
awesome

#/home/chille/configs/bin/remapkeys.sh other