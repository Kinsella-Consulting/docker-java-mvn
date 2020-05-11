#!/bin/bash

CONTAINER='java-swing-app-mvn'

docker run -ti --rm \
        -e _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --security-opt label=type:container_runtime_t \
        --network=host \
        "${CONTAINER}" /start/HelloWorldSwing
