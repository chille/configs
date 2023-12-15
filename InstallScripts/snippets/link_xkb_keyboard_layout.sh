#!/bin/bash

# Include configuration
source "${BASH_SOURCE%/*}/../functions.sh"

# Check that we are root and sudo if not
run_as_root

# Link the keyboard layout
ln -s /home/$USERNAME/configs/keyboardlayout /usr/share/X11/xkb/symbols/chille
