#!/bin/bash

if [ `hostname` = "chille-macbook15" ]; then
	# MacBook 15" Early 2013 (With retina display)

	# Scale things so they not get too small
	export GDK_SCALE=2

	# For some reason we need to explicitly set the screen resolution, or else it will be unset and screen will be blank
	xrandr --output eDP-1-1 --mode 2880x1800

elif [ `hostname` = "chille-desktop" ]; then
	# For Apple keyboards
	echo "Setting keymap for Apple keyboard"

else
	# For laptop
	echo "Setting keymap for PC keyboard";
fi

# Never turn off screen
#xset -dpms

# Turn of screen after 1 hour
xset dpms 3600 3600 3600

# No screensaver or blanking
xset s off
xset s noblank

# Make sure the keys are mapped correctly
/home/chille/configs/bin/remapkeys.sh other

# Start window manager
awesome