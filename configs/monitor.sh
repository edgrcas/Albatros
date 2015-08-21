#!/usr/bin/env bash

if [ $DEV_USER ]; then
    adduser $DEV_USER
    addgroup $DEV_GROUP    
    while true
    do
        inotifywait -r -e create --format '%w%f' /var/www | xargs -r chown $DEV_USER:$DEV_GROUP
    done
fi
