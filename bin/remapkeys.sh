#!/bin/bash

if [ "$1" = "roxterm" ]; then
	# Restore keymapping to normal when using the terminal
	xdotool keyup Ctrl
	setxkbmap -rules evdev -model evdev -layout chille -variant mixed_roxterm
#	xdotool keydown Super
else
	# Remap Control_L and Super_L to get more OS X like keybindings in all applications
	xdotool keyup Super
	setxkbmap -rules evdev -model evdev -layout chille -variant mixed
#	sleep 0.2
#	xdotool keydown Control_L
fi