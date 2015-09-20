#!/bin/bash

if [ "chille-desktop" = `hostname` ];
then
	echo "Desktop"
	setxkbmap -rules evdev -model evdev -layout chille -variant mixed

elif [ "chille-macbook" = `hostname` ];
then
	echo "Macbook"

	# Select keymap
	setxkbmap -rules evdev -model evdev -layout chille # -variant mixed

	# Setup a resolution with lower DPI on the internal monitor
	if `xrandr | grep -q "1280x800"`;
	then
		echo "Mode 1280x800 already present"
	else
		xrandr --newmode "1280x800" 83.50 1280 1352 1480 1680 800 803 809 831 -hsync +vsync
		xrandr --addmode eDP1 1280x800
	fi

	# Select the lower resolution
	xrandr --output eDP1 --mode 1280x800


	# Check for external monitor
	if `xrandr | grep -q "HDMI2 disconnected"`;
	then
		# Laptop is running without external monitor
		echo "Just the laptop, do nothing"
	else
		# Select resolution on external monitor
		if `xrandr | grep -q "1680x1050"`;
		then
			echo "At work"
			xrandr --output HDMI2 --mode 1680x1050
			xrandr --output HDMI2 --right-of eDP1
		else
			echo "At home"
			xrandr --output HDMI2 --mode 1280x1024
			xrandr --output HDMI2 --right-of eDP1
		fi
	fi

	# Touch pad settings
	#1 7 for retina
	synclient MinSpeed=.74
	synclient MaxSpeed=2.59
	synclient AccelFactor=0.02
	synclient MaxTapTime=0
	synclient HorizTwoFingerScroll=1


#	chmod 777 /sys/class/backlight/intel_backlight/brightness

elif [ "chille-laptop" = `hostname` ] ; then
	echo "Laptop"

fi
