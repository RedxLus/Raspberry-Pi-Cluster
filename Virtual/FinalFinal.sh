#! /bin/bash

# 1. quemar
# 2. archivo ssh
# 3. hostname
echo "CAMBIAR HOSTNAME"
echo -n "Seleccione una opcion [si - no]"
  read cambiohostname
  case $cambiohostname in
     si)
       sudo raspi-config
     ;;
     no)
        echo "Saliendo"
     ;;
     *)
        echo "Numero no reconocido."
     ;;
  esac
# 4. Ip estatica
nano /etc/dhcpcd.conf
  interface eth0
  static ip_address=192.168.1.200/24
  static routers=192.168.1.1
  static domain_name_servers=192.168.1.1
reboot
# 5. Dockers
echo "Instalar Docker"
echo -n "Seleccione una opcion [si - no]"
  read instdocker
  case $instdocker in
     si)
        curl -sSL get.docker.com | sh && \
          sudo usermod pi -aG docker
          newgrp docker
     ;;
     no)
        echo "Saliendo"
     ;;
     *)
        echo "Numero no reconocido."
     ;;
  esac
 ##### sudo usermod -aG docker $USER
# 6. Swap
sudo dphys-swapfile swapoff && \
  sudo dphys-swapfile uninstall && \
  sudo update-rc.d dphys-swapfile remove
sudo swapon --summary
# 7. cmd
sudo nano /boot/cmdline.txt
 #### cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
# 8. reboot
sudo reboot
# 9. Kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update -q && \
  sudo apt-get install -qy kubeadm


aptitude search '~i(!~ODebian)'
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
dpkg -C
apt-mark showhold
dpkg --audit

sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup
sudo apt edit-sources
  deb http://httpredir.debian.org/debian stretch main
  deb http://httpredir.debian.org/debian stretch-updates main
  deb http://security.debian.org stretch/updates main
  deb http://httpredir.debian.org/debian buster main
  deb http://httpredir.debian.org/debian buster-updates main
  deb http://security.debian.org buster/updates main
sudo apt update
sudo apt-get dist-upgrade





<< --DEBUG--

    kubectl get nodes

    kubectl describe nodes

    journalctl -u kubelet

--DEBUG--

# GET TOKEN AND SHA
#        kubeadm token create --print-join-command
