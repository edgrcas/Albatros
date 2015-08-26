# Albatros
Docker Lamp

##Features
Base Image: **Ubuntu:15**
|Package           | Version                        | 
 ----------------- | ---------------------------- | 
| Supervisor | `3.0`            | 
| Apache | `2.4.10 (Ubuntu)`            | 
| PHP | `5.6`            | 
| Composer | `1.0-dev`         | 
| Sass | `3.4.15`         | 
| Mongo Drive     | `1.6.10`            |
| MySQL           | `5.6.24, for debian-linux-gnu (x86_64)` | 
| PhpMyAdmin      | `4.2.12deb2` | 
| Node           | `v0.12.5` | 
| npm           | `2.11.2` | 
| Python         | `3.4.3` | 

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
Run the image, binding associated ports, and mounting the present working directory:
```
docker run -p 8000:80 -p 2200:22 -p 3306:3306 -v $(pwd):/var/www/html:rw edaniel15/albatros
```
## Services
### MySQL
Connect on localhost:3306, **user** root, **password** root.
