#!/bin/bash

SUDO="sudo"

if id -ng | grep docker; then
    SUDO=""
fi

$SUDO docker build --rm=true -t ubuntu1604-dumb-init - < Dockerfile-ubuntu1604-dumb-init
