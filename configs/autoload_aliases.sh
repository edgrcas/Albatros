#!/bin/bash

DIRECTORY_CONFIG='/domain_configs'
COUNTER=0
PROYECT_NAME=''

if [ -d "$DIRECTORY_CONFIG"  ]; then

    for PATH_DOMAIN in "$DIRECTORY_CONFIG"/*
    do
        let COUNTER=COUNTER+1
        PROYECT_NAME=$(printf "proyecto_%s.conf" "$COUNTER")
	    echo "Creando configuracion vhost para: $PATH_DOMAIN"
	    cp $PATH_DOMAIN /etc/apache2/sites-available/$PROYECT_NAME
        cat $PATH_DOMAIN
	    a2ensite $PROYECT_NAME
        echo "%%%%%%%%%FINALIZADO%%%%%%%%%%%"
    done
fi
