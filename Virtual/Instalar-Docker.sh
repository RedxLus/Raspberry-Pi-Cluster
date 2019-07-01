#! /bin/bash
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

sudo curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
    
sudo apt update

sudo apt install docker-ce -y
sudo systemctl enable docker
sudo systemctl start docker

sudo groupadd docker
sudo groupadd docker

