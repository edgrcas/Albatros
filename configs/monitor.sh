#!/usr/bin/env bash

if [ $DEV_USER ]; then
    while true
    do
        inotifywait -r -e create --format '%w%f' demoMon | xargs -r chown $DEV_USER:$DEV_GROUP
    done
fi
