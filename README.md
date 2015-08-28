Albatros
===================
Imagen LAMP para docker, contiene docker-compose. 

Features
-------------
Base Image: **Ubuntu:15**

- **Supervisor 3.0**, Sistema de control de procesos [+Info](http://supervisord.org/).
- **Apache 2.4.10 (Ubuntu)**, Http Server [+Info](http://httpd.apache.org/).
- **PHP 5.5**, [+Info](http://php.net/downloads.php).
- **Composer 1.0.0-alpha10**, [+Info](https://getcomposer.org/).
- **Mongo Drive 1.6.10**, [+info](http://docs.mongodb.org/ecosystem/drivers/).
- **MySQL 5.6.24, for debian-linux-gnu (x86_64)**, [+Info](https://www.mysql.com/).
- **PhpMyAdmin 4.2.12deb2**, MySql Administrador [+Info](https://www.phpmyadmin.net/).
- **Node v0.12.5**, [+Info](http://blog.nodejs.org/2015/06/22/node-v0-12-5-stable/).
- **npm v2.11.2**, [+Info](https://www.npmjs.com/).
- **PhantomJS 1.8.9**, [+Info](http://phantomjs.org/download.html).
- **Python 3.4.3**, [+info](https://www.python.org/).

Docker Install
-------------
Reemplazar Ubuntu por el usuario del host.
```
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker Ubuntu  
sudo service docker start
```
Docker Compose Install
-------------
Es una herramienta para la definición y ejecución de aplicaciones multi-contenedores con Docker.
```
sudo su
curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
exit
docker-compose --version
```

## Run
Los contenedores estan automatizados con docker-compose, solo tienes que ejecutar.
```
docker-compose up
```
## Services
### MySQL
Conectate a MySql desde: localhost:3306, **user** root, **password** root.

