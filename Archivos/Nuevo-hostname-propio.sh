#!/bin/bash

##CAMBIAR HOSTNAME DE ESTA MAQUINA##
clear
hostn=$(cat /etc/hostname)
echo "ESTE ES SU NOMBRE DE EQUIPO ACTUAL:"
hostname
echo "¿QUIERE CAMBIARLO?"
echo "1. Si"
echo "2. No. (Salir)"
echo -n "Seleccione una opcion [1 - 2]"
  read seleccion
  case $seleccion in
     1)
        echo "Escriba el nuevo nombre del equipo:"
        read nuevohostname
    
        sed -i "s/$hostn/$nuevohostname/g" /etc/hosts
        sed -i "s/$hostn/$nuevohostname/g" /etc/hostname
        hostnamectl set-hostname $nuevohostname
        reboot
     ;;
     2)
        echo "No cambiado, se mantiene:"
        hostname
     ;;
     *)
        echo "Numero no reconocido."
     ;;
esac
