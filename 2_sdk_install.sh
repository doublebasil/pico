#!/bin/bash
# Script to download the pico c++ SDK to /home/$USER/.pico/
# Check if the SDK is already downloaded
if [ -d "/home/$USER/.pico/pico-sdk" ]
then
    printf "/home/$USER/.pico/pico-sdk already exists. Exiting\n"
    exit
fi
# Check the PICO_SDK_PATH is either not set or is empty
if [ ! -z "${PICO_SDK_PATH+xxx}" ]
then 
    echo PICK_SDK_PATH is already set so cannot continue\n
    exit
fi
# Check if the user wants to download the SDK
USER_INPUT=""
while [ "$USER_INPUT" != "yes" ] && [ "$USER_INPUT" != "no" ] && [ "$USER_INPUT" != "YES" ] && [ "$USER_INPUT" != "NO" ]
do
    printf "Download pico-sdk to /home/$USER/.pico/ ? [yes/no] "
    read USER_INPUT
done
if [ "$USER_INPUT" == "no" ] || [ "$USER_INPUT" == "NO" ]
then
    echo Exiting
    exit
elif [ "$USER_INPUT" != "yes" ] && [ "$USER_INPUT" != "YES" ]
then
    echo Unexpected input
    exit
fi
# If ~/.pico/ doesn't exist, make it exist
if [ ! -d "/home/$USER/.pico" ]
then
    mkdir /home/$USER/.pico
fi
# --- Download the repo
# Temporarily change directory
pushd /home/$USER/.pico
git clone https://github.com/raspberrypi/pico-sdk.git
echo "" >> ~/.bashrc
echo "# Variables for Raspberry Pico" >> ~/.bashrc
echo "export PICO_SDK_PATH=/home/$USER/.pico/pico-sdk/" >> /home/$USER/.bashrc
source /home/$USER/.bashrc
# Return to previous directory
popd
# Show .bashrc
cat /home/$USER/.bashrc
