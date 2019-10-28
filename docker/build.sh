#!/bin/bash -e
##
## resources:
## https://docs.zephyrproject.org/latest/getting_started/index.html#get-the-source-code
##
##
## started with:
## $ docker run -ti -v $PWD/mnt:$(pwd)/output afb489d932bc
##
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=$HOME/zephyr-sdk-0.10.3

echo 'unset CFLAGS CXXFLAGS' >> /etc/profile.d/unset_cflags.sh


## TODO shift this to docker file?
## install zephyr sources
pip3 install -U west

## clone zephyr repository
west init zephyrproject
cd zephyrproject
west update

## install python dependencies
pip3 install -r zephyr/scripts/requirements.txt


## build hello world
cd zephyrproject/zephyr
source zephyr-env.sh
west build -b reel_board samples/hello_world


## obtain build artifacts
#TODO
