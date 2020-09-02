#!/bin/bash

echo -e "Ejecutammos el script con el usuario: \e[32m $USER \033[0m"

echo -e " \e[34m------------------- Actualizamos el sistema --------------- \033[0m"
sudo apt-get update -y

echo -e " \e[34m------------------- Descargamos docker-compose --------------- \033[0m"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo -e " \e[34m------------------- Damos permidos --------------- \033[0m"
sudo chmod +x /usr/local/bin/docker-compose

echo -e " \e[34m------------------- Comprobamos que la instalación haya sido correctamente --------------- \033[0m"
docker-compose --version
