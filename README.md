# docker__zephyr

Contains a Dockerfile for building an docker image and its container for zephyr.

Setup for Nordic PCA10040 board (Embedded Linux Conference Europe, Lyon 2019).

Implicitely will run ```git clone https://github.com/Rubusch/zephyr.git``` inside the docker container.


## Build

```
$ cd ./docker/
$ time docker build --no-cache --tag 19.04 -t rubuschl:zephyr .
$ time docker run -ti --rm -v $PWD/output:/mnt rubuschl:zephyr
```


## Debug

**NOTE**: privileged mode is not _safe_, the docker container is supposed rather to allow for archiving of the toolchain


```
$ docker run -ti --privileged -v $PWD/output:/mnt rubuschl:zephyr /bin/bash
docker $>
```

## Target

Building the board support package (bsp) for the target, e.g. the NRF52_PCA10040 eval board

```
docker $> ./build.sh
docker $> source ~/env.sh
docker $> cd ~/zephyrproject
docker $> west build -b nrf52_pca10040 zephyr/samples/bluetooth/beacon
```

Flashing the target

```
docker $> west flash --erase
```

Use the /dev/ttyACM0 device for debugging the target.
