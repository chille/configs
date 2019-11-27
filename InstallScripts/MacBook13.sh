#!/bin/bash

# Make the keyboard backlight work on MacBook's
echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"\nACTION=="add", SUBSYSTEM=="backlight", KERNEL=="ap>
addgroup chille video
