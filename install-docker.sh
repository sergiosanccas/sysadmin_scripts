#!/bin/bash

echo -e "Ejecutammos el script con el usuario: \e[32m $USER \033[0m"

echo -e " \e[34m------------------- Actualizamos el sistema --------------- \033[0m"
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Anadimos la key"
sudo apt-key fingerprint 0EBFCD88


sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Actualizamos e instalamos docker"
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "Anadimos el usuario $USER al grupo"
sudo usermod -aG docker $USER
