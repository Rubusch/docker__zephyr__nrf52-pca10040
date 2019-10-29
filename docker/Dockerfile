FROM ubuntu:19.04

WORKDIR /root

## resources
## https://docs.zephyrproject.org/latest/getting_started/installation_linux.html
##

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge

## fix missing tzdata setup
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata locales

## zephyr setup
RUN apt-get install -y   --no-install-recommends git cmake ninja-build gperf \
                         ccache dfu-util device-tree-compiler wget python3-pip \
                         python3-setuptools python3-tk python3-wheel xz-utils \
                         file make gcc gcc-multilib

## NOTE
# A recent DTC version (1.4.6 or higher) is required. Check what version you
# have by using dtc --version. If you have an older version, either install a
# more recent one by building from source, or use the one that is bundled in
# the Zephyr SDK by installing it and setting the ZEPHYR_SDK_INSTALL_DIR
# environment variable.

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


## get sources
RUN git clone -j4 https://github.com/Rubusch/zephyr.git


## SDK
RUN cd zephyr && \
    wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.10.3/zephyr-sdk-0.10.3-setup.run && \
    chmod +x zephyr-sdk-0.10.3-setup.run && \
    ./zephyr-sdk-0.10.3-setup.run -- -d ~/zephyr-sdk-0.10.3



## copy build.sh
COPY build.sh /root/build.sh

CMD ["/bin/bash", "/root/build.sh"]
