#!/usr/bin/env bash
# Autor: Edgar Castanheda

if [ $DEV_USER ]; then

    adduser -disabled-password --gecos "" $DEV_USER

    message () {
       printf "####> $1\n"
    }

    path="/var/www/"
    shift
    sha=0
    USER=$DEV_USER

    if [ $DEV_GROUP ]; then
        GROUP=$DEV_GROUP
    else
        GROUP=$USER
    fi

    message "Watching $path (Como $USER:$GROUP)"

    update_sha() {
        sha=`ls -lR --time-style=full-iso $path | sha1sum`
    }

    update_sha
    previous_sha=$sha

    build() {

        #if [[ $? != 0  ]]; then
        find $path -user root -type f -mmin -1 -printf 'FLE %Td %.8TT %f\n'
        find $path -user root -type d -mmin -1 -printf 'DIR %Td %.8TT %f\n'
        #Buscar Archivos
        find $path -user root -type f -mmin -1 | tr "\n" " " | xargs -r chmod 755
        find $path -user root -type f -mmin -1 | tr "\n" " " | xargs -r chown $USER:$GROUP
        #Carpetas
        find $path -user root -type d -mmin -1 | tr "\n" " " | xargs -r chmod 755
        find $path -user root -type d -mmin -1 | tr "\n" " " | xargs -r chown $USER:$GROUP

    }

    compare() {
        update_sha
        if [[ $sha != $previous_sha  ]] ; then
            build
            update_sha
            previous_sha=$sha
        fi

    }

    trap build SIGINT
    trap exit SIGQUIT

    while true; do
        compare
        sleep 1
    done

fi
