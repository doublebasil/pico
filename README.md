# What is this repo

A guide for myself, which streamlines some of the install stuff for the pico. 
I originally had a bunch of .sh scripts for the setup, but I've decided it's 
better to copy paste the commands from here, to give a better understanding of 
what's actually happening.

## Installing dependencies for Debian

This is all based on Raspberrys fairly bloated setup script:

https://github.com/raspberrypi/pico-setup

You can find more advice about the setup here:

https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf

apt installs:

```
sudo apt update
GIT_DEPS="git"
SDK_DEPS="cmake gcc-arm-none-eabi gcc g++"
OPENOCD_DEPS="gdb-multiarch automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev"
VSCODE_DEPS="wget"
UART_DEPS="minicom"
ALL_DEPS="$GIT_DEPS $SDK_DEPS $OPENOCD_DEPS $VSCODE_DEPS $UART_DEPS pkg-config"
sudo apt install $ALL_DEPS
sudo apt autoremove
```

## Raspberries repos

Raspberry provide some useful repos for the Pico C++ SDK:

https://github.com/raspberrypi/pico-pico.git

https://github.com/raspberrypi/pico-examples.git

https://github.com/raspberrypi/pico-extras.git

https://github.com/raspberrypi/pico-playground

The SDK is required for building c/c. pico-sdk has submodules which are 
required for the pico w. Extras has stuff for SD cards and displayes, 
and playground contains examples for extras. 

These are added as submodules to this repository. 
Install these repos and add the environment variables to .bashrc

```
git submodule update --init --recursive
echo "" >> /home/$USER/.bashrc
echo "# Raspberry Pico variables" >> /home/$USER/.bashrc
echo export PICO_SDK_PATH="$PWD/raspberry-repos/pico-sdk" >> /home/$USER/.bashrc
echo export PICO_EXAMPLES_PATH="$PWD/raspberry-repos/pico-examples" >> /home/$USER/.bashrc
echo export PICO_EXTRAS_PATH="$PWD/raspberry-repos/pico-extras" >> /home/$USER/.bashrc
echo export PICO_PLAYGROUND_PATH="$PWD/raspberry-repos/pico-playground" >> /home/$USER/.bashrc
echo "" >> /home/$USER/.bashrc
source /home/$USER/.bashrc
```

## Building the examples

This is different depending on if you're using a pico or a pico w.

For a standard pico:

```
mkdir raspberry-repos/pico-examples/build
pushd raspberry-repos/pico-examples/build
cmake ..
make
popd
```

For a pico w

```
mkdir raspberry-repos/pico-examples/build
pushd raspberry-repos/pico-examples/build
cmake -DPICO_BOARD=pico_w ..
make
popd
```

## Uploading an example

Hold the BOOTSEL button and then plug in the pico. A drive should appear. 
Using a file manager, go into pico-examples/build/blink, and drag the 
.uf2 file to the RPI-RP2. It should blink.

## Installing and using picotool

There's also picoprobe but I don't want that.

picotool is a submodule of this repository.

```
git submodule update --init --recursive
pushd raspberry-repos/picotool/
mkdir build
cd build
cmake ..
make
sudo cp picotool /usr/local/bin
popd
```

Also run this line to prevent you needing to use sudo with picotool

```
sudo cp raspberry-repos/picotool/udev/99-picotool.rules /etc/udev/rules.d/
```

See this for more details

https://github.com/raspberrypi/picotool/blob/master/README.md

picotool load file.uf2 && picotool reboot

I'm trying to find a way to get into bootsel mode without having to unplug the USB...

You can put a pico into BOOTSEL mode by setting it's baud rate to specifically 1200. 
You can list usbs using lsusb, you'll need to apt install usbutils. 

However, I think the pico has to be communicating over usb/serial, such as with 
hello world from pico-examples, so not a perfect solution.

```
sudo stty -F /dev/ttyACM0 1200
```

You can listen to serial output using:

```
minicom 
```

## Documentation Links

Pinout              -> https://datasheets.raspberrypi.com/pico/Pico-R3-A4-Pinout.pdf

Pico Datasheet      -> https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf

Raspberrys Website  -> https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html

Pico W datasheet    -> https://datasheets.raspberrypi.com/picow/pico-w-datasheet.pdf
