#!/bin/bash
if ! pgrep swaylock; then
	swaylock --daemonize --show-failed-attempts --color 000000 --image /home/chille/padlock.png --scaling center
fi
