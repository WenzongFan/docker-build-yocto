#!/bin/bash

workdir="`dirname $0`/yocto"
workdir=`readlink -f $workdir`

if [ ! -d "$workdir/poky" ]; then
    cd $workdir
    git clone git://git.yoctoproject.org/poky
fi

if [ ! -d $workdir/builds ]; then
    mkdir -m 777 -p $workdir/builds
fi

SUDO="sudo"

if id -ng | grep docker; then
    SUDO=""
fi

$SUDO docker run -it -v $workdir:/mnt ubuntu1604-dumb-init /mnt/poky-build.sh
