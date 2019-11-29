#!/bin/bash

# MacBooks have mixed BKSL / TLDE while Apple USB keyboards are correct
if [ `hostname` = "chille-desktop" ]; then
	mixed=""
else
	mixed="mixed_"
fi

# Different layout for terminal and other applications
if [ "$1" = "roxterm" ]; then
	application="roxterm"
else
	application="basic"
fi

# Release all pressed keys
xdotool keyup Super Ctrl Control_L

# Change keymap
setxkbmap -rules evdev -model evdev -layout chille -variant $mixed$application