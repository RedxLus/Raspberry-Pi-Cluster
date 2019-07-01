#! /bin/bash

# 1. quemar
# 2. archivo ssh
# 3. hostname
  sudo raspi-config
# 4. Ip estatica
  echo "profile static_eth0" >> /etc/dhcpcd.conf
  echo "static ip_address=192.168.0.100/24" >> /etc/dhcpcd.conf
  echo "static routers=192.168.0.1" >> /etc/dhcpcd.conf
  echo "static domain_name_servers=8.8.8.8" >> /etc/dhcpcd.conf
# 5. Dockers
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
sudo echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install docker-ce
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
 ##### sudo usermod -aG docker $USER
# 6. Swap
sudo dphys-swapfile swapoff && \
  sudo dphys-swapfile uninstall && \
  sudo update-rc.d dphys-swapfile remove
sudo swapon --summary
# 7. cmd
nano /boot/cmdline.txt
 #### cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
# 8. reboot
reboot
# 9. Kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update -q && \
  sudo apt-get install -qy kubeadm


