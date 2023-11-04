#!/bin/bash
# A script to install pico c++ dependencies for debian distributions
sudo apt update

GIT_DEPS="git"
SDK_DEPS="cmake gcc-arm-none-eabi gcc g++"
OPENOCD_DEPS="gdb-multiarch automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev"
VSCODE_DEPS="wget"
UART_DEPS="minicom"

ALL_DEPS="$GIT_DEPS $SDK_DEPS $OPENOCD_DEPS $VSCODE_DEPS $UART_DEPS"

sudo apt install $ALL_DEPS
sudo apt autoremove
