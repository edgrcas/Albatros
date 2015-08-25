#!/bin/bash

echo "> Revisando si tienes phantomjs instalado..."
if hash phantomjs 2>/dev/null; then
    echo "Tienes ya instalado phantomjs!"
    phantomjs -v
else
    echo "Instalando phantomjs-1.9.8"
    echo "> entrando /usr/local/share/"
    cd /usr/local/share/

    echo "> realizando wget del empaquetado del instalador"
    wget https://repo1.maven.org/maven2/com/github/klieber/phantomjs/1.9.8/phantomjs-1.9.8-linux-x86_64.tar.bz2

    echo "> extrayendo el instalador"
    tar jxvf phantomjs-1.9.8-linux-x86_64.tar.bz2

    echo "> creado los accesos directos"
    ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/ /usr/local/share/phantomjs
    ln -s /usr/local/share/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
fi
