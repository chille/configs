#!/bin/bash

# Make the keyboard backlight work on MacBook's
echo -e 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"\nACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"\n\nACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", RUN+="/bin/chgrp video /sys/class/leds/%k/brightness"\nACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"\n' | sudo tee /etc/udev/rules.d/backlight.rules
sudo addgroup chille video