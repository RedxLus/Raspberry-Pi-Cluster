#! /bin/bash
sudo su -

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

apt-get update && apt-get install -y kubeadm

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "El nombre de este equipo es: $HOSTNAME "
echo "¿Quiere cambiarlo?"
echo "[y - n]"
read cambiarhost
case $cambiarhost in
     y)
        hostnamectl set-hostname $nuevohost
     ;;
     n)
      echo "Saliendo"
     ;;
     *)
        echo "No reconocido."
     ;;
  esac

echo "¿Quiere cambiar la contraseña?"
echo "[y - n]"
read cambiarcontra
case $cambiarcontra in
     y)
        passwd
     ;;
     n)
      echo "Sin cambiar contraseña"
     ;;
     *)
        echo "No reconocido."
     ;;


kubeadm init --pod-network-cidr 172.16.81.0/16
