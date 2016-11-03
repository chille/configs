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
