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
source ~/env.sh

## build for reel board
cd ~/zephyrproject/zephyr

## clean
test -d build && rm -rf build

## build for nrf52_pca10040
west build -b nrf52_pca10040 samples/bluetooth/beacon

## obtain build artifacts
west flash --erase
