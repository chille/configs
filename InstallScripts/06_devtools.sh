#!/bin/bash

# Include configuration
source functions.sh

# Check that the script is executed by root
check_root

# Dev tools
apt-get install \
	pkg-config \
	iwyu \
	gdb \
	cmake
