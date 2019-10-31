# docker__zephyr

Contains a Dockerfile for building an docker image and its container for zephyr.

Implicitely will run ```git clone https://github.com/Rubusch/zephyr.git``` inside the docker container.


## Build

```
$ cd ./docker/
$ time docker build --no-cache --tag 19.04 -t rubuschl:zephyr .
$ time docker run -ti --rm -v $PWD/output:/mnt rubuschl:zephyr
```


## Debug


```
$ docker run -ti -v $PWD/output:/mnt rubuschl:zephyr /bin/bash
```
