FROM ubuntu:19.10
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER=""


################################################################################
## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge

RUN apt-get install -y   \
            tzdata \
            locales \
            build-essential \
            flex \
            bison \
            libncurses5

## zephyr setup (cmake > 3.13.1)
RUN apt-get install -y   --no-install-recommends \
            git \
            cmake \
            ninja-build \
            gperf \
            ccache \
            dfu-util \
            device-tree-compiler \
            wget \
            python3-pip \
            python3-setuptools \
            python3-tk \
            python3-wheel \
            xz-utils \
            file \
            make \
            gcc \
            gcc-multilib

## (opt) tools for debugging and working
RUN apt-get install -y   \
            vim \
            screen \
            minicom \
            sudo

################################################################################
## setup user and run stuff under user
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


################################################################################
## setup user and run stuff under user
RUN useradd "$USER" -m --password "$USER"
RUN usermod -a -G sudo "$USER"
RUN sed -i '/%sudo/s/.*/%sudo   ALL=NOPASSWD: ALL/' /etc/sudoers


################################################################################
## zephyr SDK
RUN mkdir -p /home/$USER/zephyrproject

RUN cd /home/$USER/zephyrproject && wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.10.3/zephyr-sdk-0.10.3-setup.run
RUN cd /home/$USER/zephyrproject && chmod +x zephyr-sdk-0.10.3-setup.run
RUN cd /home/$USER/zephyrproject && ./zephyr-sdk-0.10.3-setup.run -- -d ~/zephyr-sdk-0.10.3

## set up 'unset preset flags' command script
RUN echo 'unset CFLAGS CXXFLAGS' >> /etc/profile.d/unset_cflags.sh


################################################################################
## get zephyr sources via west (regular way to install)

RUN pip3 install west
RUN cd /home/$USER && west init zephyrproject
RUN cd /home/$USER/zephyrproject && west update

## (opt) use my own branch
RUN cd /home/$USER/zephyrproject && rm -rf zephyr && git clone https://github.com/Rubusch/zephyr.git

## continue zephyr sources installation
RUN cd /home/$USER/zephyrproject && pip3 install -r zephyr/scripts/requirements.txt


################################################################################
## specific: Nordic nRF52-PCA10040 board

# TODO download some official toolchain, problem: page seems buggy
#RUN cd /home/$USER/zephyrproject && wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2

COPY gcc-arm-none-eabi-8-2019-q3-update-linux-pt1.tar.xz /home/$USER/gcc-arm-none-eabi-8-2019-q3-update-linux-pt1.tar.xz
RUN cd /home/$USER/zephyrproject && tar -xvJf /home/$USER/gcc-arm-none-eabi-8-2019-q3-update-linux-pt1.tar.xz

COPY gcc-arm-none-eabi-8-2019-q3-update-linux-pt2.tar.xz /home/$USER/gcc-arm-none-eabi-8-2019-q3-update-linux-pt2.tar.xz
RUN cd /home/$USER/zephyrproject && tar -xvJf /home/$USER/gcc-arm-none-eabi-8-2019-q3-update-linux-pt2.tar.xz

COPY JLink_Linux_V644e_x86_64.deb /home/$USER/JLink_Linux_V644e_x86_64.deb
RUN dpkg -i /home/$USER/JLink_Linux_V644e_x86_64.deb

COPY nRF-Command-Line-Tools_10_3_0_Linux-amd64.deb /home/$USER/nRF-Command-Line-Tools_10_3_0_Linux-amd64.deb
RUN dpkg -i /home/$USER/nRF-Command-Line-Tools_10_3_0_Linux-amd64.deb

## needs DTC > 1.4.7
RUN cd /home/$USER/zephyrproject && git clone --branch v1.4.7 https://git.kernel.org/pub/scm/utils/dtc/dtc.git dtc
RUN cd /home/$USER/zephyrproject/dtc && make && make install

RUN chown $USER:$USER -R /home/$USER


################################################################################
## command mode
COPY env.sh /home/$USER/env.sh
COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
