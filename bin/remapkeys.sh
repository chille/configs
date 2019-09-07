#!/bin/bash

if [ "$1" = "roxterm" ]; then
	# Restore keymapping to normal when using the terminal
	xdotool keyup Ctrl

	if [ `hostname` = "chille-desktop" ]; then
		setxkbmap -rules evdev -model evdev -layout chille -variant roxterm
		echo "a"
	else
		setxkbmap -rules evdev -model evdev -layout chille -variant mixed_roxterm
		echo "b"
	fi
#	xdotool keydown Super
else
	# Remap Control_L and Super_L to get more OS X like keybindings in all applications
	xdotool keyup Super

	if [ `hostname` = "chille-desktop" ]; then
		setxkbmap -rules evdev -model evdev -layout chille -variant basic
		echo "c"
	else
		setxkbmap -rules evdev -model evdev -layout chille -variant mixed
		echo "d"
	fi
#	sleep 0.2
#	xdotool keydown Control_L
fi