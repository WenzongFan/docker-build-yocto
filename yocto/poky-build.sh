#!/bin/bash

YOCTO=/mnt
BUILDDIR=`mktemp -d $YOCTO/builds/build.XXXXXXXX`

mkdir -m 777 -p $YOCTO/builds/downloads
mkdir -m 777 -p $YOCTO/builds/sstate-cache

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

cd $YOCTO/poky
. ./oe-init-build-env $BUILDDIR

cat <<EOF >>$BUILDDIR/conf/local.conf

DL_DIR = "$BUILDDIR/../downloads"

EOF

bitbake -k world
