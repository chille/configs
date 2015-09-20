#!/bin/bash

# date +%s.%N >> /home/chille/time.log

# WINDOW=`xdotool getactivewindow | xargs xprop -id | awk '/WM_CLASS/{print $4}' | cut -d\" -f2`

sleep 0.2

if [ "$1" = "roxterm" ]; then
	# Restore keymapping to normal when using the terminal
	echo "OMG Roxterm! :D"

	xmodmap -e "remove control = Super_L"
	xmodmap -e "remove mod4 = Control_L"

	xmodmap -e "add control = Control_L"
	xmodmap -e "add mod4 = Super_L"
else
	# Remap Control_L and Super_L to get more OS X like keybindings in all applications
	echo "Other window"

	xmodmap -e "remove control = Control_L"
	xmodmap -e "remove mod4 = Super_L"

	xmodmap -e "add control = Super_L"
	xmodmap -e "add mod4 = Control_L"
fi

# date +%s.%N >> /home/chille/time.log
