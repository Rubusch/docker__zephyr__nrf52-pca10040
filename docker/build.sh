#!/bin/bash -e
##
## resources:
## https://docs.zephyrproject.org/latest/getting_started/index.html#get-the-source-code
##
##
## started with:
## $ docker run -ti -v $PWD/mnt:$(pwd)/output afb489d932bc
##

## prepare SDK environment
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=$HOME/zephyr-sdk-0.10.3

# ## set up 'unset preset flags' command script
# echo 'unset CFLAGS CXXFLAGS' >> /etc/profile.d/unset_cflags.sh
#
# ## TODO shift this to docker file?
# ## install zephyr sources
# pip3 install west
#
# ## clone zephyr repository
# west init zephyrproject
# cd zephyrproject
# west update
#
# ## install python dependencies
# pip3 install -r zephyr/scripts/requirements.txt
   
## zephyr setup
#cd ~/zephyrproject
#west init --mr=v1.14.1 ~/zephyrproject
#west update
#pip3 install -r zephyr/scripts/requirements.txt

## nordic PCA10040 v1.2.4 board
## tool collection (segger, nrf...)
cd ~/zephyrproject && tar -xvJf /mnt/gcc-arm-none-eabi-8-2019-q3-update-linux-pt1.tar.xz
cd ~/zephyrproject && tar -xvJf /mnt/gcc-arm-none-eabi-8-2019-q3-update-linux-pt2.tar.xz
apt-get install -y build-essential flex bison libncurses5 #libgpm2 libtinfo5
dpkg -i /mnt/JLink_Linux_V644e_x86_64.deb
dpkg -i /mnt/nRF-Command-Line-Tools_10_3_0_Linux-amd64.deb


   
## build hello world
cd ~/zephyrproject/zephyr
source zephyr-env.sh
west build -b reel_board samples/hello_world


## obtain build artifacts
#TODO
