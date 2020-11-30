[![CircleCI](https://circleci.com/gh/Rubusch/docker__zephyr__nrf52-pca10040.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__zephyr__nrf52-pca10040)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

# Docker Container Description: Zephyr, nRF52 PCA10040

Contains a Dockerfile for building an docker image and its container for zephyr.  

Setup for Nordic nRF52 PCA10040 board (Embedded Linux Conference Europe, Lyon 2019).  

Implicitely will run ```git clone https://github.com/Rubusch/zephyr.git``` inside the docker container.  


![nRF52 PCA10040 connected](pics/nRF52_PCA10040.jpg)


## References

https://docs.zephyrproject.org/latest/boards/arm/nrf52_pca10040/doc/index.html

Configuration of the necessary software: building and flashing of nordic boards (via segger).  
https://docs.zephyrproject.org/latest/guides/tools/nordic_segger.html  

gcc-arm-none-eabi toolchain documentation  
https://docs.zephyrproject.org/latest/getting_started/toolchain_3rd_party_x_compilers.html?highlight=gnuarmemb  

download of original gcc-arm-none-eabi toolchain (link seems down, tar.gz)  
https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2  

download of original nRF command line tools (tar.gz)  
https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/nRFCommandLineTools1041Linuxamd64tar.gz  

download of original JLink (segger, .deb)  
https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb  



## Build

```
$ cd ./docker/
$ time docker build --build-arg USER=$USER -t rubuschl/zephyr-nrf52:$(date +%Y%m%d%H%M%S) .
```

(opt) Append ``--no-cache`` for really re-building the container, which may fix some build bugs  


## Usage

In case of Tag **20191104161353**, enter the container or simply build leaving out the ``/bin/bash``  

```
$ docker images
    REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/zephyr-nrf52    20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ...

$ docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER --device=/dev/ttyS0 -v $PWD/configs:/home/$USER/configs -v $PWD/zephyr:/home/$USER/zephyrproject/zephyr rubuschl/zephyr-nrf52:20191104161353
```

Make sure the device is plugged (/dev/ttyS0 exists)  
NB: Appending ``--privileged`` is not _safe_! Mainly this is used for such things as connecting the USB (SEGGER) the easiest way possible.  
NB: Append ``/bin/bash`` to enter the current container for debugging  


## Target

#### Build example

Example of building the board support package (bsp) for the target, e.g. the nRF52 PCA10040 board  

```
docker $> ./build.sh
```

NB: after re-login needs to execute ``build.sh`` or at least fix all python dependencies are around (TODO to be improved)  


#### Manually build an example  

```
docker $> cd ~/zephyrproject/zephyr
ddocker $> west build -b nrf52_pca10040 zephyr/samples/bluetooth/beacon
```

Flashing the target  

```
docker $> west flash --erase
```


## Miscellaneous


Serial console 

```
docker $> minicom -D /dev/ttyS0 -b 115200
```

For convenience provide an udev rule, and joint the **plugdev** group  

```
docker $> echo 'ATTR{idProduct}=="0204", ATTR{idVendor}=="0d28", MODE="0666", GROUP="plugdev"' | sudo tee -a /etc/udev/rules.d/50-cmsis-dap.rules
docker $> udevadm control --reload-rules
```

(opt) Debug the target  

```
docker $> west debug
```

