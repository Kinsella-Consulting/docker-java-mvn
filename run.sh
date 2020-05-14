#!/bin/bash

CONTAINER='java-swing-app-mvn'

docker run -ti --rm \
        -e DISPLAY=$(ipconfig getifaddr en0):0 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /tmp/.docker.xauth \
        --network=host \
        -e DISPLAY=$(ipconfig getifaddr en0):0 "${CONTAINER}"
