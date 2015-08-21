# Albatros
Docker Lammp

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
