# Setup guide for pico

The debian dependency installer is a streamlined version of this script:

https://github.com/raspberrypi/pico-setup

You can find more advice about the setup here

https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf

There's a lot of un-necessary stuff in Raspberry's setup script - my script just has the apt installs.

Incase you don't know, you can run the .sh files using
```
sudo chmod +x deb_deps_install.sh
./deb_deps_install.sh
```

## Raspberries repos

Raspberry provide some useful repos for the Pico C++ SDK:

https://github.com/raspberrypi/pico-examples.git

https://github.com/raspberrypi/pico-extras.git

https://github.com/raspberrypi/pico-playground

pico-examples is most useful. pico-playground is similar to examples, but contains stuff from pico-extras.
I've added these as submodules to this repository, so you can download all of them using this command
```
git submodule update --init --recursive
```
You'll also need to install the pico-sdk and set the PICO_SDK_PATH variable

https://github.com/raspberrypi/pico-sdk.git

You can do that using of the the scripts in this repo

## Links

Pinout              -> https://datasheets.raspberrypi.com/pico/Pico-R3-A4-Pinout.pdf

Pico Datasheet      -> https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf

Raspberrys Website  -> https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html
