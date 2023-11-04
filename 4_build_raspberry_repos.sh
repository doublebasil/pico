#!/bin/bash
# Clones pico-examples, pico-extras and pico-playground as submodules
# and then builds them
git submodule update --init --recursive
# Check if the pico SDK is installed and setup, as its needed for building
if [ -z "${PICO_SDK_PATH+xxx}" ];
then 
    echo PICK_SDK_PATH is not set, cannot build
    exit
elif [ -z "$PICO_SDK_PATH" ] && [ "${PICK_SDK_PATH+xxx}" = "xxx" ];
then
    echo PICO_SDK_PATH is set but is empty, cannot build
    exit
fi
# If the PICK_SDK_PATH is set, lets hope it's set properly
# Build the pico-examples
cd raspberry-repos/pico-examples/build
cmake ..
make
cd ../../pico-extras/build
cmake ..
make
cd ../../pico-playground/build
cmake ..
make
cd ../../..
