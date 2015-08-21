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

## Run
Run the image, binding associated ports, and mounting the present working directory:
```
docker run -p 8000:80 -p 2200:22 -p 3306:3306 -v $(pwd):/var/www/html:rw edaniel15/albatros
```
## Services
### MySQL
Connect on localhost:3306, **user** root, **password** root.
